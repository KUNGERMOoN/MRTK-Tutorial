Shader "Unlit/PointShader"
{
    Properties
    {
        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma enable_d3d11_debug_symbols
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                UNITY_TRANSFER_FOG(o, o.vertex);
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                float2 fragCoord = float2(i.vertex.x / _ScreenParams.x, i.vertex.y / _ScreenParams.y);
                float2 center = UnityObjectToClipPos(float4(0, 0, 0, 1)).xy;
                float2 centerCoord = float2(center.x / _ScreenParams.x, center.y / _ScreenParams.y);
                float dist = length(fragCoord - centerCoord);
                return float4(centerCoord, 0, 0);
            }
            ENDCG
        }
    }
}
