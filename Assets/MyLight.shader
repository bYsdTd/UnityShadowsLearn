﻿Shader "Custom/MyLight"
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
            #pragma multi_compile _ SHADOWS_SCREEN
            #pragma multi_compile _ VERTEXLIGHT_ON

            #include "UnityStandardBRDF.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            ENDCG
        }

        Pass
        {
            Tags { "LightMode" = "ForwardAdd"}
            Blend One One
            ZWrite off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdadd_fullshadows
            
            #include "UnityStandardBRDF.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            ENDCG
        }

        Pass
        {
            Tags { "LightMode" = "ShadowCaster"}

            CGPROGRAM
            #pragma vertex vertShadowCaster
            #pragma fragment fragShadowCaster
            // #pragma multi_complie_shadowcaster

            #include "Shadows.cginc"
            ENDCG
        }

    }
}
