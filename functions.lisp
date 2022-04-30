(in-package :raylib)

(defcfun ("InitAudioDevice" init-audio-device) :void)

(defcfun ("LoadSound" load-sound) (:struct sound)
  (filename :string))

(defcfun ("PlaySound" play-sound) :void
  (sound (:struct sound)))
