package classes
{
	
	/**
	 * ...
	 * @author CatalinI
	 */
	public class AssetsParticles
	{
		[Embed(source="../particles/particle.pex", mimeType="application/octet-stream")]
		public static var ParticleXML:Class;
		
		[Embed(source="../particles/texture.png")]
		public static var ParticleTexture:Class;
	}
	
}