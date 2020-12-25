#if !defined (LIGHTING_CGINC)
#define LIGHTING_CGINC

struct vertexData
{
    float4 vertex : POSITION;
    float3 normal : NORMAL;
};

struct v2f
{
    float3 normal : TEXCOORD0;
    float4 _ShadowCoord : TEXCOORD1;
    // SHADOW_COORDS(1)
    float4 pos : SV_POSITION;
};

// sampler2D _ShadowMapTexture;

v2f vert(vertexData v)
{
    v2f o;
    o.pos = UnityObjectToClipPos(v.vertex);
    o.normal = UnityObjectToWorldNormal(v.normal);
    
    // 用内置函数计算
    // o._ShadowCoord = ComputeScreenPos(o.pos);

    // 自己计算
    // o._ShadowCoord.xyw = o.pos.xyw * 0.5;
    // o._ShadowCoord.xy = float2(o._ShadowCoord.x, o._ShadowCoord.y*_ProjectionParams.x)+o._ShadowCoord.w;
    // o._ShadowCoord.zw = o.pos.zw;

    // 直接用宏
    TRANSFER_SHADOW(o)
    return o;
}

fixed4 frag(v2f i): SV_TARGET
{
    float3 normal = normalize(i.normal);
    float3 lightDir = _WorldSpaceLightPos0.xyz;

    // pcf
    // float2 offset = float2(0.5,0.5)/_ScreenParams.xy;
    // float4 shadowVals;
    // i._ShadowCoord.xy /= i._ShadowCoord.w;
    // shadowVals.x = tex2D(_ShadowMapTexture, i._ShadowCoord.xy);
    // shadowVals.y = tex2D(_ShadowMapTexture, i._ShadowCoord.xy);
    // shadowVals.z = tex2D(_ShadowMapTexture, i._ShadowCoord.xy);
    // shadowVals.w = tex2D(_ShadowMapTexture, i._ShadowCoord.xy);
    // float shadow = dot(shadowVals, 0.25f);
    
    // simple sample
    // float shadow = tex2D(_ShadowMapTexture, i._ShadowCoord.xy/i._ShadowCoord.w);

    // buildin
    fixed shadow = SHADOW_ATTENUATION(i);
    return dot(normal, lightDir) * shadow * _LightColor0;
}

#endif