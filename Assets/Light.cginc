struct appdata
{
    float4 vertex : POSITION;
    float3 normal : NORMAL;
};

struct v2f
{
    float3 normal : TEXCOORD1;
    float4 vertex : SV_POSITION;
};

v2f vert (appdata v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.normal = UnityObjectToWorldNormal(v.normal);
    return o;
}

fixed4 frag (v2f i) : SV_Target
{
    float3 normal = normalize(i.normal);
    float3 lightDir = _WorldSpaceLightPos0.xyz;
    return fixed4(0.2,0.2,0.2,1) * dot(normal, lightDir);
}