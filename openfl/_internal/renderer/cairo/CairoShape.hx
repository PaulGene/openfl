package openfl._internal.renderer.cairo;


import openfl.display.DisplayObject;

@:access(openfl.display.DisplayObject)
@:access(openfl.display.Graphics)
@:access(openfl.geom.Matrix)


class CairoShape {
	
	
	public static inline function render (shape:DisplayObject, renderSession:RenderSession):Void {
		
		if (!shape.__renderable || shape.__worldAlpha <= 0) return;
		
		var graphics = shape.__graphics;
		
		if (graphics != null) {
			
			CairoGraphics.render (graphics, renderSession);
			
			if (graphics.__cairo != null) {
				
				if (shape.__mask != null) {
					
					renderSession.maskManager.pushMask (shape.__mask);
					
				}
				
				var cairo = renderSession.cairo;
				var scrollRect = shape.scrollRect;
				
				//context.globalAlpha = shape.__worldAlpha;
				var transform = shape.__worldTransform;
				
				if (renderSession.roundPixels) {
					
					var matrix = transform.__toMatrix3 ();
					matrix.tx = Math.round (matrix.tx);
					matrix.ty = Math.round (matrix.ty);
					cairo.matrix = matrix;
					
				} else {
					
					cairo.matrix = transform.__toMatrix3 ();
					
				}
				
				cairo.setSourceSurface (graphics.__cairo.target, graphics.__bounds.x, graphics.__bounds.y);
				cairo.paintWithAlpha (shape.__worldAlpha);
				
				//
				//if (scrollRect == null) {
					//
					//context.drawImage (graphics.__canvas, graphics.__bounds.x, graphics.__bounds.y);
					//
				//} else {
					//
					//context.drawImage (graphics.__canvas, scrollRect.x - graphics.__bounds.x, scrollRect.y - graphics.__bounds.y, scrollRect.width, scrollRect.height, graphics.__bounds.x + scrollRect.x, graphics.__bounds.y + scrollRect.y, scrollRect.width, scrollRect.height);
					//
				//}
				//
				if (shape.__mask != null) {
					
					renderSession.maskManager.popMask ();
					
				}
				
			}
			
		}
		
	}
	
	
}