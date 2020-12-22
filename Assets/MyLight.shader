Shader "Custom/MyLight"
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
            Tags { "LightMode" = "ForwardBase"}

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityStandardBRDF.cginc"
            #include "Lighting.cginc"
            ENDCG
        }

        Pass
        {
            Tags { "LightMode" = "ForwardAdd"}
            Blend One One

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdadd_fullshadows
            #include "UnityStandardBRDF.cginc"
            #include "Lighting.cginc"
            ENDCG
        }

        Pass
        {
            Tags { "LightMode" = "ShadowCaster"}

            CGPROGRAM
            #pragma vertex vertShadowCaster
            #pragma fragment fragShadowCaster
            #include "Shadows.cginc"
            ENDCG
        }

    }
}
