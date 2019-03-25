Shader "Progress/BarWithFrame" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_Progress("Progress", Range(0.0, 1.0)) = 0
		_FrameColor("FrameColor", Color) = (1,1,1,1)
		_FrameWidthU("FrameWidthU", Range(0.0, 1.0)) = 0.1
		_FrameWidthV("FrameWidthV", Range(0.0, 1.0)) = 0.1
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

			#define PULSE(a, b, x) (step((a),(x)) - step((b),(x)))
			#define RPULSE(a, b, x) (step((x),(a)) + step((b),(x)))

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
			fixed4 _FrameColor;
			float _FrameWidthU;
			float _FrameWidthV;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				// 枠を書く
				float af = RPULSE(_FrameWidthU, 1.0 - _FrameWidthU, i.uv.x) || RPULSE(_FrameWidthV, 1.0 - _FrameWidthV, i.uv.y);
				
				// 線を書く
				float al = step(i.uv.x - _FrameWidthU, _Progress * (1.0 - _FrameWidthU * 2.0)) * (1.0 - af);

				fixed4 col = af * _FrameColor + al * _Color;
				return col;
			}
			ENDCG
		}
	}
}