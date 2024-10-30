pub fn start() -> Unit {  
  @wasm4.set_palette(1, @wasm4.rgb(0xFFF45C))
  @wasm4.set_palette(2, @wasm4.rgb(0xF6B44F))
  @wasm4.set_palette(3, @wasm4.rgb(0xEC6841))
  @wasm4.set_palette(4, @wasm4.rgb(0x3d2e14))
  @wasm4.set_draw_colors(1,index=1)
  @wasm4.set_draw_colors(2,index=2)
  @wasm4.set_draw_colors(3,index=3)
  @wasm4.set_draw_colors(4,index=4)
  
  
}
pub fn update() -> Unit {
  
  game.srp()
  
  game.draw()
  
  game.music()
}





//set界面逻辑
//developer界面逻辑
//填五关数值
pub fn click_z(self:Game) -> Bool{

  if @wasm4.get_gamepad(index=1).button_2 == true {
    self.click_count+=5
    if self.click_awa!=5{
      music_button()
    }
    self.click_awa=5
    
    return false
    }
  else{
    if self.click_awa==5{
      self.click_awa=0
      
      return true
      }
    return false  
    }
}
pub fn click_x(self:Game) -> Bool{

  if @wasm4.get_gamepad(index=1).button_1 == true {
    self.click_count+=6
    if self.click_awa!=6{
      music_button()
    }
    self.click_awa=6
    
    return false
    }
  else{
    if self.click_awa==6{
      self.click_awa=0
      
      return true
      }
    return false  
    }
}
pub fn click_left(self:Game) -> Bool{

  if @wasm4.get_gamepad(index=1).button_left == true {
    self.click_count+=1
    if self.click_awa!=1{
      music_button()
    }
    self.click_awa=1
    
    return false
    }
  else{
    if self.click_awa==1{
      self.click_awa=0
      
      return true
      }
    return false  
    }
}
pub fn click_down(self:Game) -> Bool{
  if @wasm4.get_gamepad(index=1).button_down == true {
    self.click_count+=2
    if self.click_awa!=2{
      music_button()
    }
    self.click_awa=2
    
    return false
    }
  else{
    if self.click_awa==2{
      self.click_awa=0
      
      return true
      }
    return false  
    }
}
pub fn click_right(self:Game) -> Bool{  
  if @wasm4.get_gamepad(index=1).button_right == true {
    self.click_count+=3
    if self.click_awa!=3{
      music_button()
    }
    self.click_awa=3
    
    return false
    }
  else{
    if self.click_awa==3{
      self.click_awa=0
      
      return true
      }
    return false  
    }
  }
pub fn click_up(self:Game) -> Bool{  
  if @wasm4.get_gamepad(index=1).button_up == true {
    self.click_count+=4
    if self.click_awa!=4{
      music_button()
    }
    self.click_awa=4
    
    return false
    }
  else{
    if self.click_awa==4{
      self.click_awa=0
      
      return true
      }
    return false  
    }
  }

let random_a:Int=392
let random_c:Int=29261
pub fn random()->Int{
  game.seed=(random_a*game.seed+random_c)%(game.click_count+111111)
  if game.click_count>111111{
    game.click_count=random()
  }
  return game.seed%100
  }

pub fn random_range(start:Int,over:Int)->Int{
  return start+random()%(over-start+1)
  }