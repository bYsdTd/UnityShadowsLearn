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
    float4 shadowCoordinates : TEXCOORD1;
    float4 vertex : SV_POSITION;
};

sampler2D _ShadowMapTexture;

v2f vert(vertexData v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.normal = UnityObjectToWorldNormal(v.normal);
    o.shadowCoordinates = o.vertex;
    return o;
}

fixed4 frag(v2f i): SV_TARGET
{
    float3 normal = normalize(i.normal);
    float3 lightDir = _WorldSpaceLightPos0.xyz;

    i.shadowCoordinates.xy = i.shadowCoordinates.xy / i.shadowCoordinates.w;
    i.shadowCoordinates.xy = (i.shadowCoordinates.xy+1) * 0.5;

    float attenuation = tex2D(_ShadowMapTexture, float2(i.shadowCoordinates.x, 1-i.shadowCoordinates.y));
    return dot(normal, lightDir) * attenuation;
}

#endif