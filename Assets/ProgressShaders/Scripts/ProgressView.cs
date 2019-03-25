using UnityEngine;

namespace ProgressShaders
{
    public class ProgressView : MonoBehaviour
    {
        [SerializeField]
        private TextMesh percentageViewer = null;

        private Material progressMaterial = null;

        public int Progress { get; private set; }

        protected virtual void Start()
        {
            var rndr = GetComponent<Renderer>();

            if (rndr != null)
            {
                progressMaterial = rndr.material;

                Report(0);
            }
        }

        public void Report(int value)
        {
            Progress = value;
            var progressF = value * 0.01f;

            if (progressMaterial != null)
            {
                progressMaterial.SetFloat("_Progress", progressF);
            }

            if (percentageViewer != null)
            {
                percentageViewer.text = progressF.ToString("P0");
            }
        }
    }
}


