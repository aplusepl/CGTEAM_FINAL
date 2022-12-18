Shader "shader/eval/ie2"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Depth("Depth", Range(0, 1)) = 1
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

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

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			sampler2D _MainTex;
			float _Depth;
			sampler2D _CameraDepthTexture;

			fixed4 frag(v2f i) : SV_Target
			{
				// Test01
				fixed depth = UNITY_SAMPLE_DEPTH(tex2D(_CameraDepthTexture, i.uv));
				fixed4 col = fixed4(depth, depth, depth, 1.0) * _Depth;
				return col;

				// Test02
				//fixed depth = UNITY_SAMPLE_DEPTH(tex2D(_CameraDepthTexture, i.uv));
				//depth = pow(Linear01Depth(depth), _Depth); //https://docs.unity3d.com/kr/2020.1/Manual/SL-DepthTextures.html
				//return depth;

				// Test03
				//fixed depth = UNITY_SAMPLE_DEPTH(tex2D(_CameraDepthTexture, i.uv));
				//fixed4 col = fixed4(depth, depth, depth, 1.0);
				//col = pow(col, _Depth);
				//return col;
			}
			ENDCG
		}
	}
}