//
//  Renderer.swift
//  SwiftVG
//
//  Created by Simon Whitty on 25/3/17.
//  Copyright © 2017 WhileLoop Pty Ltd. All rights reserved.
//

protocol RendererTypeProvider {
    associatedtype Color
    associatedtype Path
    associatedtype Transform
    associatedtype Float
    associatedtype Point
    associatedtype Rect
    associatedtype BlendMode
    associatedtype LineCap
    associatedtype LineJoin
    associatedtype Image
    
    func createFloat(from float: Builder.Float) -> Float
    func createPoint(from point: Builder.Point) -> Point
    func createRect(from rect: Builder.Rect) -> Rect
    func createColor(from color: Builder.Color) -> Color
    func createBlendMode(from mode: Builder.BlendMode) -> BlendMode
    func createTransform(from transform: Builder.Transform) -> Transform
    func createPath(from path: Builder.Path) -> Path
    func createPath(from subPaths: [Path]) -> Path
    func createLineCap(from cap: Builder.LineCap) -> LineCap
    func createLineJoin(from join: Builder.LineJoin) -> LineJoin
    func createImage(from image: Builder.Image) -> Image?
    
    func createEllipse(within rect: Rect) -> Path
    func createLine(from origin: Point, to desination: Point) -> Path
    func createLine(between points: [Point]) -> Path
    func createPolygon(between points: [Point]) -> Path
    func createText(from text: String, with font: String, at origin: Point, ofSize pt: Float) -> Path?
    
    func createRect(from rect: Rect, radii: Builder.Size) -> Path
}

protocol Renderer {
    associatedtype Provider: RendererTypeProvider
    
    func perform(_ commands: [RendererCommand<Provider>])
}

enum RendererCommand<T: RendererTypeProvider> {
    case pushState
    case popState
    
    case concatenate(transform: T.Transform)
    case translate(tx: T.Float, ty: T.Float)
    case rotate(angle: T.Float)
    case scale(sx: T.Float, sy: T.Float)

    case setFill(color: T.Color)
    case setStroke(color: T.Color)
    case setLine(width: T.Float)
    case setLineCap(T.LineCap)
    case setLineJoin(T.LineJoin)
    case setLineMiter(limit: T.Float)
    case setClip(path: T.Path)
    case setBlend(mode: T.BlendMode)
    
    case stroke(T.Path)
    case fill(T.Path)
    
    case draw(image: T.Image)
    
    case pushTransparencyLayer
    case popTransparencyLayer
}
