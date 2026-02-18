//
//  OfflineMapView.swift
//  Skyrise Bureau
//
//  Drop-in offline replacement for MapKit's Map view.
//  Usage mirrors the original MapKit call exactly:
//
//  OfflineMap(position: $cameraPosition) {
//      ForEach(AirportDatabase.shared.allAirports, id: \.id) { airport in
//          airportAnnotation(airport)
//      }
//      ForEach(userData.planes.compactMap { ... }, id: \.0.id) { plane, location in
//          aircraftAnnotation(plane, location: location)
//          if let route = plane.assignedRoute {
//              aircraftRouteAnnotation(route)
//          }
//      }
//  }

import SwiftUI
import CoreLocation

// MapCamera
struct OfflineMapPosition: Equatable {
    var latitude: Double
    var longitude: Double
    var zoom: Double

    /// Replaces .region(...) / .camera(...)
    static func region(center: CLLocationCoordinate2D, zoom: Double = 2.5) -> Self {
        OfflineMapPosition(latitude: center.latitude, longitude: center.longitude, zoom: zoom)
    }

    static var world: Self {
        OfflineMapPosition(latitude: 25, longitude: 15, zoom: 2.2)
    }
}

// MARK: - Map Content Protocol (mirrors MapContent)

protocol OfflineMapContent {
    var annotations: [OfflineAnnotation] { get }
    var routes:      [OfflineRoute]      { get }
}

// MARK: - Annotation Types

enum OfflineAnnotationKind {
    case airport(iata: String, name: String, isHub: Bool)
    case aircraft(registration: String, isAirborne: Bool)
}

struct OfflineAnnotation: Identifiable {
    let id: String
    let coordinate: CLLocationCoordinate2D
    let kind: OfflineAnnotationKind
}

struct OfflineRoute: Identifiable {
    let id: UUID = UUID()
    let origin:      CLLocationCoordinate2D
    let destination: CLLocationCoordinate2D
    let isActive:    Bool   // true = plane currently flying this route
}

// MARK: - Content Builder Result

struct OfflineMapContentGroup: OfflineMapContent {
    var annotations: [OfflineAnnotation]
    var routes:      [OfflineRoute]
}

// MARK: - Convenience Constructors matching your annotation functions
// Replace the bodies of your existing airportAnnotation / aircraftAnnotation /
// aircraftRouteAnnotation functions with these and return OfflineAnnotation/OfflineRoute.

extension Airport {
    /// Drop-in for airportAnnotation(_ airport:)
    func asOfflineAnnotation(hubIATAs: [String] = []) -> OfflineAnnotation {
        OfflineAnnotation(
            id: iata,
            coordinate: clLocationCoordinateItemForLocation,
            kind: .airport(iata: iata, name: name, isHub: hubIATAs.contains(iata))
        )
    }
}

extension FleetItem {
    /// Drop-in for aircraftAnnotation(_ plane:, location:)
    func asOfflineAnnotation() -> OfflineAnnotation {
        OfflineAnnotation(
            id: id.uuidString,
            coordinate: planeLocationInFlight,
            kind: .aircraft(registration: registration, isAirborne: isAirborne)
        )
    }
}

extension Route {
    /// Drop-in for aircraftRouteAnnotation(_ route:)
    func asOfflineRoute(isActive: Bool = false) -> OfflineRoute {
        OfflineRoute(
            origin:      CLLocationCoordinate2D(latitude: originAirport.latitude,  longitude: originAirport.longitude),
            destination: CLLocationCoordinate2D(latitude: arrivalAirport.latitude, longitude: arrivalAirport.longitude),
            isActive:    isActive
        )
    }
}

// MARK: - Web Mercator Projection

private struct Projection {
    var centerLat: Double
    var centerLon: Double
    var zoom:      Double
    var size:      CGSize

    private var scale: Double { pow(2.0, zoom) * 256.0 }

    private func mx(_ lon: Double) -> Double { (lon + 180) / 360 }
    private func my(_ lat: Double) -> Double {
        let s = sin(lat * .pi / 180)
        return 0.5 - log((1 + s) / (1 - s)) / (4 * .pi)
    }

    func point(for c: CLLocationCoordinate2D) -> CGPoint {
        CGPoint(
            x: (mx(c.longitude) - mx(centerLon)) * scale + size.width  / 2,
            y: (my(c.latitude)  - my(centerLat)) * scale + size.height / 2
        )
    }

    func coordinate(for p: CGPoint) -> CLLocationCoordinate2D {
        let px = (p.x - size.width  / 2) / scale + mx(centerLon)
        let py = (p.y - size.height / 2) / scale + my(centerLat)
        return CLLocationCoordinate2D(
            latitude:  atan(sinh(.pi * (1 - 2 * py))) * 180 / .pi,
            longitude: px * 360 - 180
        )
    }

    mutating func pan(by offset: CGSize) {
        let c = coordinate(for: CGPoint(
            x: size.width  / 2 - offset.width,
            y: size.height / 2 - offset.height
        ))
        centerLat = max(-80, min(80, c.latitude))
        centerLon = c.longitude
    }
}

// MARK: - Great Circle

private func greatCircle(from a: CLLocationCoordinate2D,
                         to b: CLLocationCoordinate2D,
                         steps: Int = 60) -> [CLLocationCoordinate2D] {
    let lat1 = a.latitude  * .pi / 180, lon1 = a.longitude * .pi / 180
    let lat2 = b.latitude  * .pi / 180, lon2 = b.longitude * .pi / 180
    let d = 2 * asin(sqrt(pow(sin((lat2-lat1)/2), 2) + cos(lat1)*cos(lat2)*pow(sin((lon2-lon1)/2), 2)))
    guard d > 0 else { return [a, b] }
    return (0...steps).map { i in
        let t = Double(i) / Double(steps)
        let A = sin((1-t)*d)/sin(d), B = sin(t*d)/sin(d)
        let x = A*cos(lat1)*cos(lon1) + B*cos(lat2)*cos(lon2)
        let y = A*cos(lat1)*sin(lon1) + B*cos(lat2)*sin(lon2)
        let z = A*sin(lat1)           + B*sin(lat2)
        return CLLocationCoordinate2D(
            latitude:  atan2(z, sqrt(x*x+y*y)) * 180 / .pi,
            longitude: atan2(y, x) * 180 / .pi
        )
    }
}

// MARK: - World Outlines

private let worldOutlines: [[(Double,Double)]] = {
    let na: [(Double,Double)] = [
        (71,-141),(70,-130),(60,-125),(49,-124),(37,-122),(32,-117),(23,-110),(15,-92),(10,-83),
        (8,-77),(9,-79),(11,-74),(11,-63),(18,-66),(25,-80),(25,-90),(30,-89),(29,-94),(26,-97),
        (30,-97),(37,-76),(42,-70),(47,-53),(47,-70),(60,-64),(63,-68),(60,-78),(55,-79),(60,-85),
        (63,-85),(65,-88),(68,-95),(72,-96),(75,-100),(78,-104),(80,-90),(83,-70),(80,-68),
        (76,-73),(72,-80),(71,-141)
    ]
    let eu: [(Double,Double)] = [
        (71,28),(70,20),(65,14),(58,5),(51,2),(51,-5),(43,-9),(36,-9),(36,-5),(37,0),(41,2),
        (43,3),(44,8),(41,12),(38,13),(37,15),(41,16),(41,19),(45,14),(46,13),(48,17),(54,18),
        (54,24),(59,24),(60,22),(60,25),(65,25),(68,28),(71,28)
    ]
    let asia: [(Double,Double)] = [
        (71,28),(68,30),(65,35),(60,40),(55,40),(42,50),(38,57),(23,57),(12,44),(11,43),(12,51),
        (22,59),(22,69),(8,77),(8,80),(10,80),(22,88),(22,91),(27,97),(16,100),(10,99),(5,103),
        (1,104),(1,110),(5,115),(20,110),(22,114),(32,121),(38,121),(38,130),(35,129),(34,131),
        (42,141),(50,140),(53,142),(60,150),(65,168),(68,162),(65,143),(59,150),(55,160),(51,156),
        (53,143),(50,140),(48,135),(42,130),(38,121),(37,122),(35,130),(35,136),(38,141),(40,140),
        (43,141),(45,142),(50,143),(60,150),(67,170),(70,170),(72,160),(73,140),(75,120),(78,100),
        (78,75),(73,68),(68,58),(65,60),(60,60),(55,60),(55,55),(48,46),(45,37),(42,30),(38,28),
        (41,28),(42,28),(45,30),(47,38),(43,44),(42,50),(55,50),(60,50),(65,40),(68,35),(71,28)
    ]
    let af: [(Double,Double)] = [
        (37,-6),(35,0),(37,10),(33,12),(30,32),(22,37),(12,43),(11,44),(0,42),(-4,40),(-10,40),
        (-11,35),(-17,37),(-23,43),(-28,32),(-34,26),(-34,18),(-30,17),(-23,14),(-18,12),
        (-16,5),(-4,9),(0,9),(4,2),(5,-8),(5,-5),(11,-16),(14,-17),(18,-16),(20,-17),(23,-14),
        (28,-15),(33,-8),(37,-6)
    ]
    let sa: [(Double,Double)] = [
        (12,-72),(10,-62),(11,-63),(8,-60),(5,-52),(4,-51),(0,-50),(-5,-35),(-8,-35),(-10,-37),
        (-15,-39),(-20,-40),(-23,-43),(-30,-50),(-33,-52),(-35,-58),(-38,-57),(-40,-62),
        (-45,-65),(-48,-65),(-52,-68),(-55,-65),(-55,-68),(-52,-73),(-46,-75),(-42,-74),
        (-38,-72),(-30,-71),(-22,-70),(-18,-70),(-15,-75),(-10,-78),(-5,-80),(0,-78),(1,-78),
        (5,-77),(11,-74),(12,-72)
    ]
    let au: [(Double,Double)] = [
        (-15,129),(-12,130),(-12,136),(-14,136),(-12,141),(-10,142),(-12,143),(-15,145),
        (-18,147),(-20,148),(-24,152),(-28,153),(-30,153),(-33,152),(-37,150),(-38,147),
        (-38,146),(-39,146),(-38,141),(-36,139),(-35,138),(-33,134),(-32,133),(-32,126),
        (-33,124),(-34,122),(-35,117),(-31,115),(-26,114),(-22,114),(-20,119),(-18,122),
        (-16,124),(-16,128),(-15,129)
    ]
    let gl: [(Double,Double)] = [
        (83,-35),(83,-20),(80,-18),(75,-18),(72,-22),(70,-25),(68,-30),(66,-35),(68,-42),
        (70,-52),(72,-56),(76,-65),(78,-68),(80,-62),(83,-48),(83,-35)
    ]
    return [na, eu, asia, af, sa, au, gl]
}()

// MARK: - OfflineMap (drop-in for Map)

struct OfflineMap {
    @Binding var position: OfflineMapPosition
    var content: OfflineMapContentGroup

    init(position: Binding<OfflineMapPosition>,
         @OfflineMapBuilder content: () -> OfflineMapContentGroup) {
        self._position = position
        self.content = content()
    }
}

extension OfflineMap: View {
    private var oceanColor:    Color { Color(red: 0.07, green: 0.09, blue: 0.12) }
    private var landColor:     Color { Color(red: 0.17, green: 0.22, blue: 0.20) }
    private var gridColor:     Color { Color.white.opacity(0.04) }
    private var routeActive:   Color { Color(red: 0.25, green: 0.85, blue: 0.55) }
    private var routeInactive: Color { Color.white.opacity(0.2) }
    private var hubColor:      Color { Color(red: 0.25, green: 0.85, blue: 0.55) }
    private var airportColor:  Color { Color(red: 0.9,  green: 0.75, blue: 0.3) }
    private var aircraftColor: Color { Color(red: 0.4,  green: 0.7,  blue: 1.0) }

    var body: some View {
        _OfflineMapRenderer(
            position:      $position,
            annotations:   content.annotations,
            routes:        content.routes,
            oceanColor:    oceanColor,
            landColor:     landColor,
            gridColor:     gridColor,
            routeActive:   routeActive,
            routeInactive: routeInactive,
            hubColor:      hubColor,
            airportColor:  airportColor,
            aircraftColor: aircraftColor
        )
    }
}

// MARK: - Result Builder

@resultBuilder
struct OfflineMapBuilder {
    static func buildBlock(_ components: OfflineMapContentGroup...) -> OfflineMapContentGroup {
        OfflineMapContentGroup(
            annotations: components.flatMap(\.annotations),
            routes:      components.flatMap(\.routes)
        )
    }
    static func buildOptional(_ c: OfflineMapContentGroup?) -> OfflineMapContentGroup {
        c ?? OfflineMapContentGroup(annotations: [], routes: [])
    }
    static func buildEither(first:  OfflineMapContentGroup) -> OfflineMapContentGroup { first }
    static func buildEither(second: OfflineMapContentGroup) -> OfflineMapContentGroup { second }
    static func buildArray(_ cs: [OfflineMapContentGroup]) -> OfflineMapContentGroup {
        OfflineMapContentGroup(annotations: cs.flatMap(\.annotations), routes: cs.flatMap(\.routes))
    }
}

extension OfflineAnnotation: OfflineMapContent {
    var annotations: [OfflineAnnotation] { [self] }
    var routes: [OfflineRoute] { [] }
}
extension OfflineRoute: OfflineMapContent {
    var annotations: [OfflineAnnotation] { [] }
    var routes: [OfflineRoute] { [self] }
}

// MARK: - Internal Renderer

private struct _OfflineMapRenderer: View {
    @Binding var position: OfflineMapPosition
    let annotations:   [OfflineAnnotation]
    let routes:        [OfflineRoute]
    let oceanColor, landColor, gridColor: Color
    let routeActive, routeInactive: Color
    let hubColor, airportColor, aircraftColor: Color

    @State private var proj = Projection(centerLat: 25, centerLon: 15, zoom: 2.2, size: .zero)
    @GestureState private var liveDrag: CGSize = .zero
    @State private var selectedAnnotation: OfflineAnnotation? = nil

    var body: some View {
        GeometryReader { geo in
            ZStack {
                oceanColor.ignoresSafeArea()

                Canvas { ctx, size in
                    var p = proj
                    p.size = size
                    if liveDrag != .zero {
                        p.pan(by: CGSize(width: -liveDrag.width, height: -liveDrag.height))
                    }
                    drawGrid(ctx: ctx, p: p)
                    drawLand(ctx: ctx, p: p)
                    drawRoutes(ctx: ctx, p: p)
                    drawAnnotations(ctx: ctx, p: p)
                }
                .gesture(
                    DragGesture(minimumDistance: 2)
                        .updating($liveDrag) { v, s, _ in s = v.translation }
                        .onEnded { v in
                            proj.size = geo.size
                            proj.pan(by: CGSize(width: -v.translation.width,
                                                height: -v.translation.height))
                            syncPosition()
                        }
                )
                .gesture(
                    MagnificationGesture()
                        .onChanged { v in
                            proj.zoom = max(1.5, min(7, proj.zoom + Double(log2(Float(v))) * 0.5))
                            syncPosition()
                        }
                )
                .onTapGesture { loc in
                    proj.size = geo.size
                    handleTap(at: loc)
                }
                .onAppear {
                    proj.size      = geo.size
                    proj.centerLat = position.latitude
                    proj.centerLon = position.longitude
                    proj.zoom      = position.zoom
                }
                .onChange(of: geo.size) { proj.size = $0 }
                .onChange(of: position) {
                    withAnimation(.spring(duration: 0.4)) {
                        proj.centerLat = position.latitude
                        proj.centerLon = position.longitude
                        proj.zoom      = position.zoom
                    }
                }

                // Callout
                if let ann = selectedAnnotation {
                    let pt = proj.point(for: ann.coordinate)
                    calloutView(for: ann)
                        .position(
                            x: min(max(pt.x, 130), geo.size.width - 130),
                            y: max(pt.y - 65, 70)
                        )
                        .transition(.scale(scale: 0.85).combined(with: .opacity))
                        .animation(.spring(duration: 0.22), value: selectedAnnotation?.id)
                }

                // Controls
                VStack {
                    HStack { Spacer(); controls }
                    Spacer()
                }
                .padding(16)
            }
        }
        .background(oceanColor)
    }

    // MARK: Drawing

    private func drawGrid(ctx: GraphicsContext, p: Projection) {
        let step: Double = p.zoom < 3 ? 30 : p.zoom < 4 ? 15 : 10
        var path = Path()
        stride(from: -180.0, through: 180.0, by: step).forEach { lon in
            path.move(to: p.point(for: .init(latitude: 80,  longitude: lon)))
            path.addLine(to: p.point(for: .init(latitude: -80, longitude: lon)))
        }
        stride(from: -80.0, through: 80.0, by: step).forEach { lat in
            path.move(to: p.point(for: .init(latitude: lat, longitude: -180)))
            path.addLine(to: p.point(for: .init(latitude: lat, longitude:  180)))
        }
        ctx.stroke(path, with: .color(gridColor), lineWidth: 0.5)
        var eq = Path()
        eq.move(to: p.point(for: .init(latitude: 0, longitude: -180)))
        eq.addLine(to: p.point(for: .init(latitude: 0, longitude: 180)))
        ctx.stroke(eq, with: .color(.white.opacity(0.07)), lineWidth: 1)
    }

    private func drawLand(ctx: GraphicsContext, p: Projection) {
        for outline in worldOutlines {
            guard outline.count > 2 else { continue }
            var path = Path()
            path.move(to: p.point(for: .init(latitude: outline[0].0, longitude: outline[0].1)))
            for (lat, lon) in outline.dropFirst() {
                path.addLine(to: p.point(for: .init(latitude: lat, longitude: lon)))
            }
            path.closeSubpath()
            ctx.fill(path,   with: .color(landColor))
            ctx.stroke(path, with: .color(.white.opacity(0.05)), lineWidth: 0.8)
        }
    }

    private func drawRoutes(ctx: GraphicsContext, p: Projection) {
        for route in routes {
            let pts = greatCircle(from: route.origin, to: route.destination)
            var path = Path()
            path.move(to: p.point(for: pts[0]))
            pts.dropFirst().forEach { path.addLine(to: p.point(for: $0)) }
            let color = route.isActive ? routeActive : routeInactive
            ctx.stroke(path,
                       with: .color(color.opacity(route.isActive ? 0.7 : 0.35)),
                       style: StrokeStyle(lineWidth: route.isActive ? 1.5 : 1,
                                         dash: route.isActive ? [5,3] : [3,4]))
        }
    }

    private func drawAnnotations(ctx: GraphicsContext, p: Projection) {
        for ann in annotations {
            let pt = p.point(for: ann.coordinate)
            let isSelected = selectedAnnotation?.id == ann.id

            switch ann.kind {
            case .airport(let iata, _, let isHub):
                let color: Color  = isHub ? hubColor : airportColor
                let radius: CGFloat = isHub ? 5 : 3.5
                if isHub {
                    ctx.fill(Path(ellipseIn: CGRect(x: pt.x-10, y: pt.y-10, width: 20, height: 20)),
                             with: .color(color.opacity(0.15)))
                }
                ctx.fill(Path(ellipseIn: CGRect(x: pt.x-radius, y: pt.y-radius,
                                                width: radius*2, height: radius*2)),
                         with: .color(color))
                if isSelected {
                    ctx.stroke(Path(ellipseIn: CGRect(x: pt.x-9, y: pt.y-9, width: 18, height: 18)),
                               with: .color(color), lineWidth: 1.5)
                }
                if p.zoom > 2.5 || isHub {
                    ctx.draw(
                        Text(iata).font(.system(size: 9, weight: .semibold, design: .monospaced))
                            .foregroundColor(.white.opacity(0.8)),
                        at: CGPoint(x: pt.x, y: pt.y + 11)
                    )
                }

            case .aircraft(let reg, let airborne):
                let color: Color = airborne ? aircraftColor : .white.opacity(0.5)
                ctx.draw(
                    Text(airborne ? "✈" : "■")
                        .font(.system(size: airborne ? 14 : 8))
                        .foregroundColor(color),
                    at: pt
                )
                if isSelected || (p.zoom > 3.5 && airborne) {
                    ctx.draw(
                        Text(reg).font(.system(size: 8, weight: .medium, design: .monospaced))
                            .foregroundColor(color.opacity(0.8)),
                        at: CGPoint(x: pt.x, y: pt.y + 13)
                    )
                }
            }
        }
    }

    // MARK: Interaction

    private func handleTap(at loc: CGPoint) {
        let nearest = annotations.min(by: {
            let a = proj.point(for: $0.coordinate), b = proj.point(for: $1.coordinate)
            return hypot(a.x-loc.x, a.y-loc.y) < hypot(b.x-loc.x, b.y-loc.y)
        })
        guard let n = nearest else { return }
        let pt = proj.point(for: n.coordinate)
        withAnimation(.spring(duration: 0.22)) {
            selectedAnnotation = hypot(pt.x-loc.x, pt.y-loc.y) < 30
                ? (selectedAnnotation?.id == n.id ? nil : n)
                : nil
        }
    }

    private func syncPosition() {
        position = OfflineMapPosition(latitude: proj.centerLat,
                                      longitude: proj.centerLon,
                                      zoom: proj.zoom)
    }

    // MARK: Callout

    private func calloutView(for ann: OfflineAnnotation) -> some View {
        VStack(spacing: 4) {
            switch ann.kind {
            case .airport(let iata, let name, let isHub):
                Text(iata)
                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                    .foregroundColor(isHub ? hubColor : airportColor)
                Text(name).font(.system(size: 11)).foregroundColor(.white.opacity(0.8))
                if isHub {
                    Text("HUB")
                        .font(.system(size: 9, weight: .heavy, design: .monospaced))
                        .foregroundColor(hubColor)
                        .padding(.horizontal, 6).padding(.vertical, 2)
                        .background(hubColor.opacity(0.15))
                        .clipShape(Capsule())
                }
            case .aircraft(let reg, let airborne):
                Text(reg)
                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                    .foregroundColor(airborne ? aircraftColor : .white.opacity(0.6))
                Text(airborne ? "In flight" : "On ground")
                    .font(.system(size: 11)).foregroundColor(.white.opacity(0.7))
            }
        }
        .padding(.horizontal, 12).padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.12), lineWidth: 1))
        .shadow(color: .black.opacity(0.4), radius: 8)
    }

    // MARK: Controls

    private var controls: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle().fill(.ultraThinMaterial).frame(width: 36, height: 36)
                Text("N").font(.system(size: 11, weight: .heavy, design: .monospaced))
                    .foregroundColor(.white.opacity(0.9))
            }
            .overlay(Circle().stroke(Color.white.opacity(0.1), lineWidth: 1))
            controlButton("plus")    { proj.zoom = min(7,   proj.zoom + 0.5); syncPosition() }
            controlButton("minus")   { proj.zoom = max(1.5, proj.zoom - 0.5); syncPosition() }
            controlButton("arrow.counterclockwise") {
                withAnimation(.spring(duration: 0.4)) {
                    proj.centerLat = position.latitude
                    proj.centerLon = position.longitude
                    proj.zoom      = position.zoom
                    selectedAnnotation = nil
                }
            }
        }
    }

    private func controlButton(_ icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.ultraThinMaterial).frame(width: 36, height: 36)
                Image(systemName: icon).font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
            }
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white.opacity(0.1), lineWidth: 1))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    @Previewable @State var position = OfflineMapPosition.world

    OfflineMap(position: $position) {
        OfflineMapContentGroup(
            annotations: [
                OfflineAnnotation(
                    id: "LHR",
                    coordinate: .init(latitude: 51.47, longitude: -0.45),
                    kind: .airport(iata: "LHR", name: "London Heathrow", isHub: true)
                ),
                OfflineAnnotation(
                    id: "BLR",
                    coordinate: .init(latitude: 13.19, longitude: 77.70),
                    kind: .airport(iata: "BLR", name: "Bengaluru Intl", isHub: true)
                ),
                OfflineAnnotation(
                    id: "plane-1",
                    coordinate: .init(latitude: 35.0, longitude: 30.0),
                    kind: .aircraft(registration: "VT-SKR", isAirborne: true)
                ),
            ],
            routes: [
                OfflineRoute(
                    origin: .init(latitude: 51.47, longitude: -0.45),
                    destination: .init(latitude: 13.19, longitude: 77.70),
                    isActive: true
                )
            ]
        )
    }
}
