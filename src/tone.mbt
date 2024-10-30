//  "do": 25280, "ri": 294, "mi": 330, "fa": 3280, "so": 392, "la": 440,  "xi": 494,
//  "do_": 523, "ri_": 4457, "mi_":6599, "fa_":8388,"so_":784,"la_":880,"xi_":988
//25280,523,494,523,784,523,8388,523,6599,523,8388,25280,523,494,523,784,523,8388,523,6599,523,8388

let back1 : Array[UInt] = [
  327, 0, 0, 0, 0, 0, 0, 0, 490, 0, 0, 0, 0, 0, 0, 0, 445, 0, 0, 418, 363, 0, 0,
  418, 445, 0, 0, 0, 0, 0, 0, 0, 418, 0, 0, 0, 363, 0, 0, 0, 327, 0, 0, 310, 280,
  0, 0, 310, 327, 0, 0, 0, 0, 0, 0, 0, 243, 0, 0, 0, 0, 0, 0, 0, 327, 0, 0, 0, 0,
  0, 0, 0, 490, 0, 0, 0, 0, 0, 0, 0, 550, 0, 0, 659, 490, 0, 0, 445, 490, 0, 0, 0,
  0, 0, 0, 0, 550, 0, 0, 0, 490, 0, 0, 0, 445, 0, 0, 418, 363, 0, 0, 327, 363, 0,
  0, 0, 363, 0, 0, 0, 327, 0, 0, 0, 0, 0, 0, 0,
]

let back2 : Array[UInt] = [
  1318, 0, 0, 0,0, 0, 0, 0, 988, 0, 0, 1318, 1244, 0, 0, 1318, 1318, 0, 0, 0, 0, 0,
  0, 0, 838, 0, 0, 988, 838, 0, 0, 988, 1108, 0, 0, 0, 0, 0, 0, 0, 880, 0, 0, 988,
  838, 0, 0, 988, 838, 0, 0, 0, 838, 0, 0, 0, 740, 0, 0, 0, 740, 0, 0, 0, 1318, 0,
  0, 0, 0, 0, 0, 0, 988, 0, 0, 1318, 1244, 0, 0, 1318, 1318, 0, 0, 0, 0, 0, 0, 0,
  838, 0, 0, 988, 838, 0, 0, 988, 1108, 0, 0, 0, 0, 0, 0, 0, 880, 0, 0, 988, 838,
  0, 0, 988, 838, 0, 0, 0, 838, 0, 0, 0, 659, 0, 0, 0, 659, 0, 0, 0,
]

let back3 : Array[UInt] = [
  163, 0, 0, 0, 163, 0, 0, 0, 163, 0, 0, 0, 163, 0, 0, 0, 209, 0, 0, 0, 209, 0, 0,
  0, 209, 0, 0, 0, 209, 0, 0, 0, 222, 0, 0, 0, 222, 0, 0, 0, 222, 0, 0, 0, 222, 0,
  0, 0, 182, 0, 0, 0, 182, 0, 0, 0, 182, 0, 0, 0, 182, 0, 0, 0, 163, 0, 0, 0, 163,
  0, 0, 0, 163, 0, 0, 0, 163, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 222, 0, 0, 0, 222, 0, 0, 0, 243, 0, 0, 0, 243, 0, 0, 0, 209, 0, 0, 0, 209,
  0, 0, 0, 182, 0, 0, 0, 182, 0, 0, 0,
]

let back4 : Array[UInt] = [
  490, 0, 0, 0, 0, 0, 0, 0, 4000, 0, 0, 0, 0, 0, 0, 0, 490, 0, 0, 490, 0, 0, 490,
  0, 4000, 0, 0, 0, 0, 0, 0, 0, 490, 0, 0, 0, 490, 0, 0, 0, 4000, 0, 0, 0, 4000,
  0, 0, 0, 490, 0, 0, 0, 0, 0, 0, 0, 4000, 0, 0, 0, 0, 0, 0, 0, 490, 0, 0, 0, 0,
  0, 0, 0, 4000, 0, 0, 0, 0, 0, 0, 0, 490, 0, 0, 490, 0, 0, 490, 0, 4000, 0, 0, 0,
  0, 0, 0, 0, 490, 0, 0, 0, 490, 0, 0, 0, 4000, 0, 0, 0, 4000, 0, 0, 0, 490, 0, 0,
  0, 0, 0, 0, 0, 4000, 0, 0, 0, 0, 0, 0, 0,
]

pub fn music(self : Game) -> Unit {
  music_back(self.mu_Stuck, self.index) //检测音效优先
}

fn music_back(mu_Stuck : Int, index : Int) -> Unit {
  if mu_Stuck == 0 {
    if game.tick % 7 != 0 {
      return
    }
    if back1[index] != 0 {
      @wasm4.tone(
        (back1[index], 0),
        @wasm4.ADSR::new(40, release=15, decay=0, attack=0),
        @wasm4.ADSRVolume::new(100, peak=100),
        @wasm4.ToneFlag::new(channel=Pulse1, mode=Duty_1_8, pan=Center),
      )
    }
    if back2[index] != 0 {
      @wasm4.tone(
        (back2[index], 0),
        @wasm4.ADSR::new(5, release=15, decay=0, attack=0),
        @wasm4.ADSRVolume::new(100, peak=100),
        @wasm4.ToneFlag::new(channel=Pulse2, mode=Duty_1_8, pan=Center),
      )
    }
    if back3[index] != 0 {
      @wasm4.tone(
        (back3[index], 0),
        @wasm4.ADSR::new(20, release=15, decay=0, attack=10),
        @wasm4.ADSRVolume::new(100, peak=100),
        @wasm4.ToneFlag::new(channel=Triangle, mode=Duty_1_8, pan=Center),
      )
    }
    if back4[index] != 0 {
      @wasm4.tone(
        (back4[index], 0),
        @wasm4.ADSR::new(5, release=15, decay=0, attack=0),
        @wasm4.ADSRVolume::new(100, peak=100),
        @wasm4.ToneFlag::new(channel=Noise, mode=Duty_1_8, pan=Center),
      )
    }
  } else {
    game.mu_Stuck -= 1
  }
  game.index += 1
    if game.index >= 128 {
      game.index = 0
    }
}

fn music_button() -> Unit {
  @wasm4.tone(
    (100, 102),
    @wasm4.ADSR::new(2, release=2, decay=1, attack=0),
    @wasm4.ADSRVolume::new(100, peak=100),
    @wasm4.ToneFlag::new(channel=Triangle, mode=Duty_1_8, pan=Center),
  )
}
