pub fn srp(self : Game) -> Unit {
  if self.stuck == 0 {
    if self.stage == -1 {
      if (self.click_up()||self.click_down()||self.click_left()||self.click_right()||self.click_z()||self.click_x()) {self.stage = 0}
    } else if self.stage == 0 {
      self.switch_from0()
    } else if self.stage == 1 {
      self.switch_from1()
    } else if self.stage == 2 {
      self.switch_from2()
    }
  } else {
    self.stuck -= 1
  }
}

pub fn initialize(self : Game) -> Unit {
  self.me = Character::new()
  self.refresh_Enemy()
  self.refresh_Influ()
}

//结束stage0后case是否归0: 是
pub fn switch_from0(self : Game) -> Unit {
  if self.stage0_case == 0 {
    self.switch_from00() //跳转逻辑
  } else if self.stage0_case == 1 {
    //self.logic_set() //
    //self.switch_to00() //
    self.logic_exit()
  } else if self.stage0_case == 2 { //***开始游戏***
    self.stage=1
    self.stage2_case=0
  } else if self.stage0_case == 3 {
    self.logic_exit()
  }
}

//结束stage1后case是否归0：是
pub fn switch_from1(self : Game) -> Unit {
  if self.stage1_case == 0 { //ready动画需要设置在0切换至1时触发
    self.prepare()
    self.switch_to11()
    //case1到case3为一个round
  } else if self.stage1_case == 1 {
    turnReset()
    self.get_enemyMove()
    self.get_myMove()
    self.switch_to12() //播放完动画再进入下一个case
  } else if self.stage1_case == 2 {
    self.settlement()
    self.switch_to13()
    //case2无需操作直接进入case3
  } else if self.stage1_case == 3 {
    self.hp_detect()
  } else if self.stage1_case == 4 {
    self.switch_to00()
  }
}

//结束stage2后case是否归0：是
pub fn switch_from2(self : Game) -> Unit {
  if self.stage2_case == 0 {
    
    self.enhance()
    self.stuck= 180
    
  } else if self.stage2_case == 1 {
    
    self.level +=1
    
    
    self.stage2_case = 2
    

  } else if self.stage2_case == 2 {
    
    self.switch_to1()
  }
}

pub fn enemyRecord(self : Game) -> Unit {
  self.influ.pt = self.enemy.t
}

pub fn clear_Me_t(self : Game) -> Unit {
  self.me.t = 0
}

pub fn enhance(self : Game) -> Unit {
  //获取一种固定的增强 level+=1
  
  set_fall(self.level+1,72,14,-0.54+0.27*(self.level).to_double(),-0.5)
  
  self.stage2_case = 1
}

pub fn getskill(self : Game) -> Unit { //增益需要调整
  if self.level >= 1 {
    self.me.attack += 2
  }
  if self.level >= 2 {
    self.enemy.attack += 2
  }
  if self.level >= 3 {
    self.me.angerBL += 1
  }
  if self.level >= 4 {
    self.me.critRate += 20
  }
  if self.level >= 5 {
    self.me.critDamage += 1
  }
}

pub fn logic_set(self : Game) -> Unit {
  if self.click_up() {

  } else if self.click_down() {

  }
}

pub fn logic_exit(self : Game) -> Unit {
  self.stage = -1
  self.stage0_case = 0
}

pub fn prepare(self : Game) -> Unit {
  self.initialize() //每局初始化
  self.getskill() //上局收获
}

pub fn get_myMove(self : Game) -> Unit {
  if self.click_left() {
    self.me.scissors()
  } else if self.click_down() {
    self.me.rock()
  } else if self.click_right() {
    self.me.paper()
  }
}

pub fn settlement(self : Game) -> Unit {
  self.round_outcome()
  self.enemyRecord()
  self.clear_Me_t()
}

pub fn round_outcome(self : Game) -> Unit {
  if self.enemy.t == self.me.t {
    self.influ.fw = 0 //平局
    self.enemy.hp -= self.me.attack / 2
    self.me.hp -= self.enemy.attack / 2
  } else if self.enemy.t % 3 + 1 == self.me.t {
    self.influ.fw = -1 //敌人失败
    self.enemy.hp -= self.me.dam_calculate()
    self.enemy.anger(1)
    self.me.anger(-1)
  } else {
    self.influ.fw = 1 //敌人胜利
    self.me.hp -= self.enemy.dam_calculate()
    self.me.anger(1)
    self.enemy.anger(-1)
  }
}

pub fn hp_detect(self : Game) -> Unit {
  if self.enemy.hp <= 0 { //***敌人死亡***
    self.enemy.hp = 0
    self.switch_to2()
  } else if self.enemy.hp > 0 && self.me.hp <= 0 { //***角色死亡***
    self.me.hp = 0
    self.switch_to14()
  } else {
    //***继续游戏***
    self.stage1_case = 1
  }
}

//一种choose敌人出招的机制
pub fn get_enemyMove(self : Game) -> Unit {
  if self.influ.fw == -1 {
    if (self.influ.pt == 1 && self.influ.tp == 1) ||
      (self.influ.pt == 1 && self.influ.tp == 3) ||
      (self.influ.pt == 2 && self.influ.tp == 3) {
      self.enemy.t = 3
    } else if (self.influ.pt == 1 && self.influ.tp == 2) ||
      (self.influ.pt == 3 && self.influ.tp == 2) ||
      (self.influ.pt == 3 && self.influ.tp == 3) {
      self.enemy.t = 2
    } else if (self.influ.pt == 2 && self.influ.tp == 1) ||
      (self.influ.pt == 2 && self.influ.tp == 2) ||
      (self.influ.pt == 3 && self.influ.tp == 1) {
      self.enemy.t = 1
    }
  } else if self.influ.fw == 1 {
    if (self.influ.pt == 1 && self.influ.tp == 1) ||
      (self.influ.pt == 1 && self.influ.tp == 3) ||
      (self.influ.pt == 2 && self.influ.tp == 3) {
      self.enemy.t = 2
    } else if (self.influ.pt == 1 && self.influ.tp == 2) ||
      (self.influ.pt == 3 && self.influ.tp == 2) ||
      (self.influ.pt == 3 && self.influ.tp == 3) {
      self.enemy.t = 1
    } else if (self.influ.pt == 2 && self.influ.tp == 1) ||
      (self.influ.pt == 2 && self.influ.tp == 2) ||
      (self.influ.pt == 3 && self.influ.tp == 1) {
      self.enemy.t = 3
    }
  }
}

//计算无加成回合伤害
pub fn anger(self : Character, num : Int) -> Unit { //c
  if self.anger * num > 0 {
    self.anger += num
  } else {
    self.anger = 0
    self.anger += num
  }
  if self.anger <= -5 {
    self.anger = -5
  }
  if self.anger >= 5 {
    self.anger = 5
  }
}

pub fn dam_calculate(self : Character) -> Int {
  let mut damage : Int = self.attack
  self.critRate += 10
  if self.anger > 0 {
    damage += self.anger
    self.anger = 0
  } else {
    self.anger = 0
  }
  if random() > self.critRate { //c random()
    self.critRate = 10
    damage *= self.critDamage
  } else {
    damage = damage
  }
  return damage
}
