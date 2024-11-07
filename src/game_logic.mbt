pub fn srp(self : Game) -> Unit {
  if self.click==6{
    self.stage=-1
    self.click=0
  }
  if self.stuck == 0 {
    if self.stage==-2{
      self.switch_fromf2()
    } else if self.stage == -1 {
      self.switch_fromf1()
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
  self.win_count=0
  self.fw = 0
  self.faceIndex = 0 
  self.scores = Scorecount::new()

  self.me.t=random_range(1,3)
  self.me = Character::new()

  self.refresh_Enemy()
  self.enemy_move=self.level

  self.getskill() //上局收获
  
}

//结束stage0后case是否归0: 是
pub fn switch_fromf2(self : Game) -> Unit {
  if self.click==5 {
      self.stage = 0 
      self.stage0_case=0
      }
  else{
    self.setting.sets(self.click)
  }
}

pub fn sets(self:Setting,click:Int) -> Unit{
  if click==2{
    self.select+=1
    if self.select>1{
      self.select=1
    }
  }
  else if click==4{
    self.select-=1
    if self.select<0{
      self.select=0
    }
  }
  else if click==1{
    if self.select==0{
      self.volumn-=10
      if self.volumn<0{
      self.volumn=0
      }
    }
    if self.select==1{
      self.difficulty-=1
      if self.difficulty<0{
      self.difficulty=0
    }
    }
  }
  else if click==3{
    if self.select==0{
      self.volumn+=10
      if self.volumn>100{
      self.volumn=100
      }
    }
    if self.select==1{
      self.difficulty+=1
      if self.difficulty>3{
      self.difficulty=3
    }
    }
  }
}
pub fn switch_fromf1(self : Game) -> Unit {
  if self.click!=0 {
      self.stage = 0 
      self.stage0_case=0
      }
}
pub fn switch_from0(self : Game) -> Unit {
  if self.stage0_case == 0 {
    self.switch_from00() //跳转逻辑
  } else if self.stage0_case == 1 {
    self.stage=-2
  } else if self.stage0_case == 2 { //***开始游戏***
    self.hh=0
    self.stage=1
    self.stage2_case=0
    self.stage1_case=0
  } else if self.stage0_case == 3 {
    self.logic_exit()
  }
}

//结束stage1后case是否归0：是
pub fn switch_from1(self : Game) -> Unit {
  if self.stage1_case == 0 {
    if (self.hh==0){self.prepare()}
    self.hh+=1
    if self.setting.difficulty==2{
      if self.hh%8==0{
        self.enemy_move=random_range(0,5)
        }
    }
    else if self.setting.difficulty==3{
      if self.hh%5==0{
        self.enemy_move=random_range(0,5)
        }
    }
    turnReset()
    self.scores.speed+=self.scores.turn_speed
    self.scores.turn_speed=300

    if self.level>=4{//沙漏
      let zc=2+self.win_count*2
      self.enemy.hp-=zc
      if zc>self.scores.max_damage{
        self.scores.max_damage=zc
      }
      set_damage(zc,false,-1)
    }
    
    self.get_enemyMove()
    if self.enemy.hp>0{
      self.switch_to11()
    }
    else{
      self.stage1_case = 3
    }
    self.stuck=30
    //case1到case3为一个round
  } else if self.stage1_case == 1 {
    self.get_myMove()
    self.switch_to12() //播放完动画再进入下一个case
  } else if self.stage1_case == 2 {
    self.settlement()
    self.switch_to13()
    //case2无需操作直接进入case3
  } else if self.stage1_case == 3 {
    self.hp_detect()
    
  } else if self.stage1_case == 4 {//玩家gg
    self.switch_tof1()
    
  }
}

//结束stage2后case是否归0：是
pub fn switch_from2(self : Game) -> Unit {
  if self.stage2_case == 0 {
    if self.level<=5{
      falling.set_fall(self.level+1,72,14,-0.54+0.27*(self.level).to_double(),-0.5)
      self.stuck= 120
    }
    self.stage2_case = 1
    
  } else if self.stage2_case == 1 {
    
    self.scores.level_score=self.getscore()
    if self.scores.level_score>self.score[self.level]{
      self.score[self.level]=self.scores.level_score
    }
    self.level +=1
    
    self.stage2_case = 2
    

  } else if self.stage2_case == 2 {//显示分数
    self.hh=0
    
    self.switch_to1()
  }
}

pub fn getscore(self:Game) -> Int{
  let mut num=0
  if self.hh<=10+2*self.level{
    num+=120*(10+2*self.level-self.hh)
  }
  num+=self.me.hp*3
  num+=self.scores.max_damage*5
  num+=self.scores.speed/self.hh
  num+=self.scores.rps_count[0]*20
  num+=self.scores.rps_count[1]*15
  num+=self.scores.rps_count[2]*10
  if self.win_count>0{
    num+=(self.scores.crit_count*500)/self.win_count
  }
  num+=(num*self.level*10)/100
  if self.setting.difficulty==1{
    num*=6/5
  }
  else if self.setting.difficulty==2{
    num*=4/3
  }
  else if self.setting.difficulty==3{
    num*=2
  }
  
  return num
}

pub fn getskill(self : Game) -> Unit { //增益需要调整
  if self.level >= 1 {
    self.me.critRate += 20
  }
  if self.level >= 2 {
    self.enemy.attack -= 2
  }
  if self.level >= 5 {
    self.me.critDamage += 1
  }
}

pub fn logic_set(self : Game) -> Unit {
  if self.click==4 {

  } else if self.click==2 {

  }
}

pub fn logic_exit(self : Game) -> Unit {
  self.stage = -1
  self.stage0_case = 0
}

pub fn prepare(self : Game) -> Unit {
  self.initialize() //每局初始化
  stageReset(self.me.hp,self.enemy.hp)
}

pub fn get_myMove(self : Game) -> Unit {
  if self.scores.turn_speed>0{
    self.scores.turn_speed-=1
  }
  if self.click==1 {
    self.me.t=1//剪刀
    self.scores.rps_count[0]+=1
  } else if self.click==2 {
    self.me.t=2//石头
    self.scores.rps_count[1]+=1
  } else if self.click==3 {
    self.me.t=3//布
    self.scores.rps_count[2]+=1
  } else if self.click==4{
    self.me.t=4//枪
  }
}


pub fn settlement(self : Game) -> Unit {
  self.round_outcome()
}

pub fn round_outcome(self : Game) -> Unit {
  let mut enWin:Int = 0
  if self.enemy.t==4{
    enWin=1
  }
  else if self.me.t==4{
    enWin=-1
  }
  else if self.enemy.t % 3 + 1 == self.me.t{
    enWin=-1
  }
  else if (self.enemy.t+1) % 3 + 1 == self.me.t{
    enWin=1
  }

  if enWin==0 {
    self.fw = 0 //平局
    self.enemy.hp -= 5
    self.me.hp -= 5
    set_damage(5,false,0)
  } else if enWin==-1 {
    self.fw = -1 //敌人失败
    let zc = self.me.dam_calculate(self.enemy,true)

    if zc>self.scores.max_damage{
      self.scores.max_damage=zc//最高伤害结算
    }

    self.enemy.hp -= zc
    self.enemy.anger(1)
    self.me.anger(-1)
    if self.level>=5{
      self.me.anger(-1)
    }
    self.win_count+=1
    
  } else if enWin==1{
    self.fw = 1 //敌人胜利
    self.me.hp -= self.enemy.dam_calculate(self.me,false)
    self.me.anger(1)
    self.enemy.anger(-1)
    if self.level>=3{
      self.me.anger(1)
    }
  }
  if self.enemy.hp<0{
      self.enemy.hp=0
    }
  if self.me.hp<0{
      self.me.hp=0
    }
}

pub fn hp_detect(self : Game) -> Unit {
  if self.enemy.hp == 0 { //***敌人死亡***
    winAndFail(-2)
    self.switch_to2()
  } else if self.me.hp == 0 { //***角色死亡***
    winAndFail(2)
    self.switch_to14()
  } else {
    //***继续游戏***
    self.stage1_case = 0
  }
}

//一种choose敌人出招的机制
pub fn get_enemyMove(self : Game) -> Unit {
  if self.me.t==4{
    self.enemy.t=4
  }
  else{
    if (self.enemy_move==0) {
      self.enemy.t=1
    }
    if (self.enemy_move==1) {
      self.enemy.t= self.enemy.t%3+1
    }
    else if (self.enemy_move==2) {
      self.enemy.t = self.me.t%3+1
    }
    else if (self.enemy_move==3) {
      self.enemy.t = (self.enemy.t+random_range(0,1))%3+1
    }
    else if (self.enemy_move==4) {
      if (self.fw!=-1){
        self.enemy.t=self.enemy.t
      }
      else{
      self.enemy.t = (self.enemy.t+random_range(0,1))%3+1
      }
    }
    else if (self.enemy_move==5) {
      if (self.fw==-1){
        self.enemy.t = (self.enemy.t+random_range(0,1))%3+1
      }
      else if (self.fw==0) {
        self.enemy.t = self.me.t%3+1
      }
      else if (self.fw==-1){
        self.enemy.t=self.enemy.t
      }
    }
  }
  self.me.t=0//本来应该检测按键是否按下作为切换回合前进条件的
}


//计算无加成回合伤害
pub fn anger(self : Character, num : Int) -> Unit { 
  if self.anger*num<0{
    self.anger=0
  }
  self.anger += num
  if self.anger <= -5 {
    self.anger = -5
  }
  if self.anger >= 5 {
    self.anger = 5
  }
}

pub fn dam_calculate(self : Character,other:Character,id:Bool) -> Int {
  let mut damage : Int = self.attack
  let mut zc_crit = self.critRate//先减伤再枪的增伤再暴击
  let mut zc_crit_damage = self.critDamage
  let mut crited:Bool=false
  let mut anger_per:Int=1
  if game.setting.difficulty>0{
    anger_per=2
  }
  if self.anger > 0 {
    damage += self.anger*2*anger_per
    if game.level>=3 && id==true{
      zc_crit+=5*self.anger*anger_per
    }
  }
  else {
    zc_crit-=20*self.anger
  }//angry

  if self.t==4{
    damage*=2
    zc_crit_damage+=1
  }//gun

  //boost

  if random()%100 < zc_crit { //c random()
    damage *= zc_crit_damage
    crited=true
    if id==true{
      game.scores.crit_count+=1
    }
  }//crit

  if other.anger>0{
    damage-=other.anger
  }

  set_damage(damage,crited,game.fw)
  return damage
}
