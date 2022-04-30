(in-package :raylib)

(include "raylib.h")

(cstruct audio-stream "AudioStream"
  (buffer "buffer" :type :pointer)
  (sample-rate "sampleRate" :type :unsigned-int)
  (sample-size "sampleSize" :type :unsigned-int)
  (channels "channels" :type :unsigned-int))

(cstruct sound "Sound"
  (stream "stream" :type (:struct audio-stream))
  (frame-count "frameCount" :type :unsigned-int))
