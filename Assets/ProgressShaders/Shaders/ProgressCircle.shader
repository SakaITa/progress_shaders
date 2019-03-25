Shader "Progress/Circle" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_Progress("Progress", Range(0.0, 1.0)) = 0
		_LineWidth("LineWidth", Range(0.0, 1.0)) = 0.4
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

			#define PI 3.14159265f
			#define PI_H 1.57079633f
			#define PULSE(a, b, x) (step((a),(x)) - step((b),(x)))

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
			float _LineWidth;

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
				fixed4 col = _Color;

				// 輪を描く
				float a = PULSE(0.5 * (1.0 - _LineWidth) , 0.5, distance(center, i.uv));

				// 角度制限
				float2 pos = (i.uv - center) * 2.0;
				float angle = -(atan2(pos.y, pos.x) - PI_H) / (PI * 2.0);
				angle = angle < 0 ? angle + 1.0 : angle;
				a *= step(angle, _Progress);

				col.a *= a;
				return col;
			}
			ENDCG
		}
	}
}