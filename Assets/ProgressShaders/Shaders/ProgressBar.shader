Shader "Progress/Bar" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_Progress("Progress", Range(0.0, 1.0)) = 0
	}
	SubShader{
		Tags {
			"Queue" = "Transparent"
			"RenderType" = "Trasparent"
		}
		LOD 200

		ZWrite Off
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};
			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			fixed4 _Color;
			float _Progress;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col = _Color;

				// 線を書く
				float a = step(i.uv.x, _Progress);

				col.a *= a;
				return col;
			}
			ENDCG
		}
	}
}