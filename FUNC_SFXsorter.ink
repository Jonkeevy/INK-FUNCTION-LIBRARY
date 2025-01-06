// BAND MANAGER GAME
// LIST instruments = none, (lead_guitar), (drumkit), (bass), (synth), (saw), (keyboard), (violin), (bassoon), (ax), (rhythm_guitar)

=== function sfx_instrument_riff(x)
{
- rhythm_guitar ^ x:
    <> # PLAY_SOUND: SOUNDS/rake-guitar-dry-83757.mp3
- lead_guitar ^ x:
    <> # PLAY_SOUND: SOUNDS/Party Whistle 3.wav
- drumkit ^ x:
    <> # PLAY_SOUND: SOUNDS/Party Whistle 3.wav
- bass ^ x:
    <> # PLAY_SOUND: SOUNDS/Party Whistle 3.wav
- synth ^ x:
    <> # PLAY_SOUND: SOUNDS/Party Whistle 3.wav
- saw ^ x:
    <> # PLAY_SOUND: SOUNDS/Party Whistle 3.wav
- keyboard ^ x:
    <> # PLAY_SOUND: SOUNDS/Party Whistle 3.wav
- violin ^ x:
    <> # PLAY_SOUND: SOUNDS/Party Whistle 3.wav
- bassoon ^ x:
    <> # PLAY_SOUND: SOUNDS/Party Whistle 3.wav
- ax ^ x:
    <> # PLAY_SOUND: SOUNDS/Party Whistle 3.wav
- else:
    <> # PLAY_SOUND: SOUNDS/Party Whistle 3.wav
}