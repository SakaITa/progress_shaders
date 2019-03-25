Shader "Progress/ExpandRound" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_Progress("Progress", Range(0.0, 1.0)) = 0
		_FrameColor("FrameColor", Color) = (1,1,1,1)
		_FrameWidth("FrameWidth", Range(0.0, 1.0)) = 0.1
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
			fixed4 _FrameColor;
			float _FrameWidth;

			#define PI 3.14159265f
			#define PI_H 1.57079633f
			#define PULSE(a, b, x) (step((a),(x)) - step((b),(x)))

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				float2 center = float2(0.5, 0.5);

				// 枠を描く
				float af = PULSE(0.5 * (1.0 - _FrameWidth), 0.5, distance(center, i.uv));

				// 円を描く
				float ar = step(distance(center, i.uv), _Progress * (1.0 - _FrameWidth) * 0.5);

				fixed4 col = af * _FrameColor + ar * _Color;
				return col;
			}
			ENDCG
		}
	}
}