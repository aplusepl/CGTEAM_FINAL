using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ie2_c : MonoBehaviour
{
    Shader myShader;       
    Material myMaterial;

    public float depth = 1f;

    void Start()
    {
        myShader = Shader.Find("shader/eval/ie2");  
        myMaterial = new Material(myShader);
    }

    private void Update()
    {
        depth = Mathf.Clamp(depth, 0.0f, 1.0f);
    }

    private void OnDisable()
    {
        if (myMaterial)
        {
            DestroyImmediate(myMaterial);
        }
    }


    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        myMaterial.SetFloat("_Depth", depth);
        Graphics.Blit(source, destination, myMaterial);
    }
}