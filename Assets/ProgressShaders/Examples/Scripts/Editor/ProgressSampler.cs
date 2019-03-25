using UnityEditor;

namespace ProgressShaders
{
    [CustomEditor(typeof(ProgressView))]
    public class ProgressSampler : Editor
    {
        public override void OnInspectorGUI()
        {
            base.OnInspectorGUI();

            var view = (ProgressView)target;
            var progress = view.Progress;

            EditorGUI.BeginDisabledGroup(!EditorApplication.isPlaying);
            var newProgress = EditorGUILayout.IntSlider("Progress", progress, 0, 100);
            EditorGUI.EndDisabledGroup();

            if (!EditorApplication.isPlaying)
            {
                EditorGUILayout.HelpBox("Progress can only be changed while plaing.", MessageType.Info);
            }

            if (progress != newProgress)
            {
                view.Report(newProgress);
            }
        }
    }
}