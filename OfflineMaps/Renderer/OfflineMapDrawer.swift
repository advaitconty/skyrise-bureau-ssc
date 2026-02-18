//
//  OfflineMapDrawer.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 18/2/26.
//

import Foundation
import SwiftUI
import CoreLocation

extension _OfflineMapRenderer {
    func drawGrid(ctx: GraphicsContext, p: Projection) {
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
    
    func drawLand(ctx: GraphicsContext, p: Projection) {
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
    
    func drawRoutes(ctx: GraphicsContext, p: Projection) {
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
    
    func drawAnnotations(ctx: GraphicsContext, p: Projection) {
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
                        Text(iata).font(.system(size: 9, weight: .semibold))
                            .fontWidth(.expanded)
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
}
