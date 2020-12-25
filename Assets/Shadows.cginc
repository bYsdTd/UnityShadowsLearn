#if !defined (SHADOWS_CGINC)
#define SHADOWS_CGINC

#include "UnityCG.cginc"

struct appdata
{
    float4 vertex : POSITION;
    float3 normal : NORMAL;
};

#if defined(SHADOWS_CUBE)
struct v2f
{
    float4 vertex :SV_POSITION;
    float3 lightDistance : TEXCOORD0;
};

v2f vertShadowCaster(appdata v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    // 当前点到Light位置的向量
    o.lightDistance = mul(unity_ObjectToWorld,v.vertex).xyz - _LightPositionRange.xyz;
    return o;
}

fixed4 fragShadowCaster (v2f i) : SV_Target
{
    float depth = length(i.lightDistance) + unity_LightShadowBias.x;
    depth *= _LightPositionRange.w;
    // 如果不支持浮点纹理，编码到rgba32
    return UnityEncodeCubeShadowDepth(depth);
}
#else

struct v2f
{
    float4 vertex : SV_POSITION;
};


v2f vertShadowCaster (appdata v)
{
    v2f o;
    o.vertex = UnityClipSpaceShadowCasterPos(v.vertex, v.normal);
    o.vertex = UnityApplyLinearShadowBias(o.vertex);
    return o;
}

fixed4 fragShadowCaster (v2f i) : SV_Target
{
    return 0;
}
#endif


#endif