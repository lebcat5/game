//剪刀石头布对应t的值
pub fn scissors(self : Character) -> Unit {
  self.t = 1
}

pub fn rock(self : Character) -> Unit {
  self.t = 2
}

pub fn paper(self : Character) -> Unit {
  self.t = 3
}

pub fn switch_from00(self : Game) -> Unit {
  if self.click_left() {
    self.stage0_case = 1 
  }
  if self.click_down() {
    self.stage0_case = 2 
  }
  if self.click_right() {
    self.stage0_case = 3 
  }
  
}

pub fn switch_to1(self : Game) -> Unit {
  if (self.click_up()||self.click_down()||self.click_left()||self.click_right()||self.click_z()||self.click_x()) {
    self.stage = 1
    self.stage1_case = 0
    self.stage2_case = 0
    if self.level == 5{
    self.stage = -1
    self.level = 0
  } 
  }
  
}

pub fn switch_to2(self : Game) -> Unit {
  self.stage1_case = 0
  self.stage = 2
}

pub fn switch_to00(self : Game) -> Unit {
  if self.click_left() {
    self.stage1_case = 0
    self.stage = 0
    self.stage0_case = 0 
    self.level = 0
  }
}

pub fn switch_to11(self : Game) -> Unit {
    self.stage1_case = 1 
    
}

pub fn switch_to12(self : Game) -> Unit {
  if self.me.t != 0 {
    myChoosing(self.me.t)
    enemyChoosing(self.enemy.t)
    self.stage1_case = 2
    self.stuck = 60
  }
}

pub fn switch_to13(self : Game) -> Unit {
  self.stuck = 60
  winAndFail(self.influ.fw)
  self.stage1_case = 3
}

pub fn switch_to14(self : Game) -> Unit {
  self.stage1_case = 4
}


pub fn test_Move(self : Game) -> Unit {
  self.test_left()
  self.test_right()
  self.test_down()
}

pub fn test_left(self : Game) -> Unit {
  if self.me.t == 1 {
    @wasm4.set_draw_colors(index=1, 2)
    @wasm4.rect(0, 0, 80, 80)
    @wasm4.text("scissors!", 10, 150)
  }
}

pub fn test_down(self : Game) -> Unit {
  if self.me.t == 2 {
    @wasm4.set_draw_colors(index=1, 2)
    @wasm4.rect(0, 0, 80, 80)
    @wasm4.text("rock!", 10, 150)
  }
}

pub fn test_right(self : Game) -> Unit {
  if self.me.t == 3 {
    @wasm4.set_draw_colors(index=1, 2)
    @wasm4.rect(0, 0, 80, 80)
    @wasm4.text("paper!", 10, 150)
  }
}

pub fn test_enemyfail(self : Game) -> Unit {
  if self.me.t == 3 {
    @wasm4.set_draw_colors(index=1, 2)
    @wasm4.rect(0, 0, 80, 80)
    @wasm4.text("test_enemyfail!", 10, 150)
  }
}

pub fn test_enemywin(self : Game) -> Unit {
  if self.me.t == 3 {
    @wasm4.set_draw_colors(index=1, 2)
    @wasm4.rect(0, 0, 80, 80)
    @wasm4.text("test_enemywin!", 10, 150)
  }
}

pub fn test_draw(self : Game) -> Unit {
  if self.me.t == 3 {
    @wasm4.set_draw_colors(index=1, 2)
    @wasm4.rect(0, 0, 80, 80)
    @wasm4.text("draw!", 10, 150)
  }
}
