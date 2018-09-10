// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

//

/*001 
	1.设置片元和顶点着色器的方法使用
	2.设置结构体进行信息变化与传递；
	3.了解部分语义（p110）POSITION大概就是CG/HSLS的语义（semantics）：赋给shader输入和输出的字符串，表达了参数的意义；
		SV_的意思大概是system-value 系统数值
		怀疑昨天的方括号之中的[PerRendererData] 也是某种修改的方式[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}


*/
Shader "Cg basic shader" { // defines the name of the shader 
	SubShader{ // Unity chooses the subshader that fits the GPU best
		Pass{ // some shaders require multiple passes
		CGPROGRAM // here begins the part in Unity's Cg

		#pragma vertex vert 
				  // this specifies the vert function as the vertex shader 将vert方法作为顶点着色器
		#pragma fragment frag
				  // this specifies the frag function as the fragment shader 将frag方法作为片元着色器

		struct a2v {
			float4 vertexPos : POSITION;
			//float3 vertexCol : COLOR;
		};	

		struct v2f
		{
			float4 pos : SV_POSITION;
			//float3 col : COLOR0;

		};

		v2f vert(a2v v) 
		// vertex shader //输入一个float4 么 名为顶点坐标的东西，然后拿到模型空间中的顶点的坐标POSITION
		{
			v2f o;
			o.pos = UnityObjectToClipPos(v.vertexPos);
			//o.col = v.vertexCol;
			return o;
		//return UnityObjectToClipPos(vertexPos);
		// this line transforms the vertex input parameter 
		// vertexPos with the built-in matrix UNITY_MATRIX_MVP
		// and returns it as a nameless vertex output parameter 
		}

		fixed4 frag(v2f i) : SV_Target // fragment shader
	{
			return fixed4(1,0,0,1.0);
	// this fragment shader returns a nameless fragment
	// output parameter (with semantic COLOR) that is set to
	// opaque red (red = 1, green = 0, blue = 0, alpha = 1)
	}

		ENDCG // here ends the part in Cg 
	}
	}
}