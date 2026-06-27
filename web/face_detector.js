// MediaPipe Face Landmarker for Flutter web
// Self-initializing module that exposes functions on window
import {
  FaceLandmarker,
  FilesetResolver,
} from 'https://cdn.jsdelivr.net/npm/@mediapipe/tasks-vision@latest/wasm/vision_bundle.js';

let faceLandmarker = null;

async function init() {
  try {
    const vision = await FilesetResolver.forVisionTasks(
      'https://cdn.jsdelivr.net/npm/@mediapipe/tasks-vision@latest/wasm/',
    );
    faceLandmarker = await FaceLandmarker.createFromOptions(vision, {
      baseOptions: {
        modelAssetPath:
          'https://storage.googleapis.com/mediapipe-models/face_landmarker/face_landmarker/float16/latest/face_landmarker.task',
      },
      runningMode: 'IMAGE',
      outputFaceBlendshapes: false,
      outputFacialTransformationMatrixes: false,
      numFaces: 1,
    });
    window.__mediapipeReady = true;
  } catch (e) {
    window.__mediapipeReady = false;
    window.__mediapipeError = e.message || 'Init failed';
  }
}

function detect(imageData) {
  try {
    if (!faceLandmarker) {
      return JSON.stringify({ error: 'Not initialized' });
    }
    const result = faceLandmarker.detect(imageData);
    if (!result || !result.faceLandmarks || result.faceLandmarks.length === 0) {
      return JSON.stringify({ error: 'No face detected' });
    }
    const face = result.faceLandmarks[0];
    return JSON.stringify({
      landmarks: face.map((l) => ({
        x: l.x,
        y: l.y,
        z: l.z,
      })),
      imgWidth: imageData.width,
      imgHeight: imageData.height,
    });
  } catch (e) {
    return JSON.stringify({ error: e.message || 'Detection error' });
  }
}

window.__mediapipeInit = init;
window.__mediapipeDetect = detect;
