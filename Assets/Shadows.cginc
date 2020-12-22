#if !defined (SHADOWS_CGINC)
#define SHADOWS_CGINC

#include "UnityCG.cginc"

struct appdata
{
    float4 vertex : POSITION;
    float3 normal : NORMAL;
};

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