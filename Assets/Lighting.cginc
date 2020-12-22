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
    float4 vertex : SV_POSITION;
};

v2f vert(vertexData v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.normal = UnityObjectToWorldNormal(v.normal);
    return o;
}

fixed4 frag(v2f i): SV_TARGET
{
    float3 normal = normalize(i.normal);
    float3 lightDir = _WorldSpaceLightPos0.xyz;
    return dot(normal, lightDir);
}

#endif