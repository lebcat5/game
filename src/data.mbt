struct Game {
  mut me : Character
  mut enemy : Character
  mut stage : Int
  mut stage0_case : Int
  mut stage1_case : Int
  mut stage2_case : Int
  mut influ : Influ
  mut level : Int
  
  mut click_awa : Int 

  mut stuck:Int
  mut mu_Stuck:Int
  mut tick:Int
  mut click_count:Int

  mut index:Int

  mut faceIndex:Int

  mut seed:Int


}

struct Character {
  mut hp : Int
  mut t : Int
  mut attack : Int
  mut critRate : Int
  mut critDamage : Int
  mut anger : Int
  mut angerBL : Int
}

struct Influ {
  tp : Int
  mut fw : Int
  mut pt : Int
}

let game : Game = Game::new()

pub fn Game::new() -> Game {
  {
    me: Character::new(),
    enemy: Character::new(),
    stage: -1,
    stage0_case: 0,
    stage1_case: 0,
    stage2_case: 0,
    level: 0,
    stuck: 0,
    mu_Stuck: 0,
    click_awa: 0,
    influ: Influ::{ tp: 1, fw: 1, pt: 2 },
    tick:0,
    click_count:0,
    index:0,
    faceIndex:1,
    seed:1234,

  }
}

pub fn Character::new() -> Character {
  {
    hp: 100,
    t: 0,
    attack: 10,
    critRate: 10,
    critDamage: 2,
    anger: 0,
    angerBL: 1,
  }
}

//刷新敌人数值
pub fn refresh_Enemy(self : Game) -> Unit {
  if self.level == 0 {
    self.enemy = {
      hp: 100,
      t: 0,
      attack: 10,
      critRate: 10,
      critDamage: 2,
      anger: 0,
      angerBL: 1,
    }
  } else if self.level == 1 {
    self.enemy = {
      hp: 100,
      t: 0,
      attack: 10,
      critRate: 10,
      critDamage: 2,
      anger: 0,
      angerBL: 1,
    }
  } else if self.level == 2 {
    self.enemy = {
      hp: 100,
      t: 0,
      attack: 10,
      critRate: 10,
      critDamage: 2,
      anger: 0,
      angerBL: 1,
    }
  } else if self.level == 3 {
    self.enemy = {
      hp: 100,
      t: 0,
      attack: 10,
      critRate: 10,
      critDamage: 2,
      anger: 0,
      angerBL: 1,
    }
  } else if self.level == 4 {
    self.enemy = {
      hp: 100,
      t: 0,
      attack: 10,
      critRate: 10,
      critDamage: 2,
      anger: 0,
      angerBL: 1,
    } 
  }
    else if self.level == 5 {
    self.enemy = {
      hp: 100,
      t: 0,
      attack: 10,
      critRate: 10,
      critDamage: 2,
      anger: 0,
      angerBL: 1,
    }
  }
}

//刷新敌人决策偏好
pub fn refresh_Influ(self : Game) -> Unit {
  if self.level == 0 {
    self.influ = { tp: 1, fw: 1, pt: 2 }
  } else if self.level == 1 {
    self.influ = { tp: 1, fw: 1, pt: 2 }
  } else if self.level == 2 {
    self.influ = { tp: 1, fw: 1, pt: 2 }
  } else if self.level == 3 {
    self.influ = { tp: 1, fw: 1, pt: 2 }
  } else if self.level == 4 {
    self.influ = { tp: 1, fw: 1, pt: 2 }
  }
}
//dam = (at+anger)*cD
//需要初始化influ

// 获取我的出招 **建议放top（为什么把函数放data里面）
//**在top获取输入，然后触发game的left down right函数
