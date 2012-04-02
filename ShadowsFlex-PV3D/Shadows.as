package {
	//import the ShadowCaster classes
	import com.everydayflash.pv3d.ShadowCaster;
	
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.MovieMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.special.CompositeMaterial;
	import org.papervision3d.objects.primitives.Cylinder;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	[SWF(width="600", height="400", framerate="31", backgroundColor="0xFFFFFF")]
	public class Shadows extends Sprite
	{
		private var view:BasicView;
		//to cast shadows we will need dummy sprite object 
		//that we can draw our shadows into using the ShadowCaster object
		private var spr:Sprite;
		//That dummy sprite will then be passed into a moviematerial 
		//where we can project our shadows into our 3D scene
		private var sprMaterial:MovieMaterial;
		private var shadowPlane:Plane;
		
		private var wire:WireframeMaterial;
		private var color:ColorMaterial;
		private var composite:CompositeMaterial;
		private var cylinder:Cylinder;
		
		//To cast shadows we will need a light
		//Declare a PointLight3D object
		private var light:PointLight3D;
		//The shadows are drawn using the ShadowCaster object
		//Declare a ShadowCaster object
		private var shadowCaster:ShadowCaster;
		
		public function Shadows()
		{
			view = new BasicView(600, 400, false, true, CameraType.FREE);
			view.camera.y = 300; view.camera.rotationX = 30;
			
			//Instantiate your dummy sprite
			spr = new Sprite();
			//draw a rectangle into your dummy sprite
			//note that if you don't want your plane to show in the scene
			//but you do want shadows, you can set the alpha of the
			//beginFill method to 0 (shadows will be drawn but the plane color fill will not)
			spr.graphics.beginFill(0xFFFFFF);
			//the larger the "drawRect" shape the better the quality of your shadows
			spr.graphics.drawRect(0, 0, 256, 256);
			
			//Add the dummy sprite to a MovieMaterial object
			sprMaterial = new MovieMaterial(spr, true, true, true);
			
			//create a plane and apply your dummy sprite MovieMaterial to it
			shadowPlane = new Plane(sprMaterial, 2000, 2000, 1, 1);
			//rotate and orient your plane so that it is aligned as the floor/ground
			shadowPlane.rotationX = 90;
			shadowPlane.y = -200;
			
			wire = new WireframeMaterial(0x0000AA);
			color = new ColorMaterial(0x0066CC);
			composite = new CompositeMaterial();
			composite.addMaterial(color);
			composite.addMaterial(wire);
			//we'll use a cylinder as the object that is going to cast the shadow
			cylinder = new Cylinder(composite, 80, 250, 8, 3);
			
			//Instantiate your light object and set the z, y axis up and to the back
			light = new PointLight3D(); light.z = 600; light.y = 500;
			//Instantiate your shadowCaster object
			//The parameters are as follows
			//ShadowCaster("name", shadow color, blend mode, shadow alpha, [filters]);
			shadowCaster = new ShadowCaster("shadow", 0x000000, BlendMode.MULTIPLY, .3, [new BlurFilter(10, 10, 1)]);
			//Set the light type (options are SPOTLIGHT and DIRECTIONAL)
			shadowCaster.setType(ShadowCaster.SPOTLIGHT);
			
			//Add your shadowPlane and Cylinder to the scene
			view.scene.addChild(shadowPlane);
			view.scene.addChild(cylinder);
			addChild(view);
			
			addEventListener(Event.ENTER_FRAME, onRenderViewport);
		}
		
		private function onRenderViewport(e:Event):void
		{
			//the invalidate() method basically clears the previously drawn shadow
			shadowCaster.invalidate();
			//the castModel method casts the shadow of an object in your scene
			//castModel parameters are as follows
			//castModel(object to cast shadow from, light, plane to cast the shadow onto
			shadowCaster.castModel(cylinder, light, shadowPlane);
			
			cylinder.yaw(2);
			cylinder.pitch(1);
			view.singleRender();
		}
	}
}
