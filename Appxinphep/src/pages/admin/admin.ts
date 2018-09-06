import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { LichvadanhsachdiemdanhPage } from '../lichvadanhsachdiemdanh/lichvadanhsachdiemdanh';
import { DanhsachxinnghiPage } from '../danhsachxinnghi/danhsachxinnghi';
import { TaothongbaoPage } from '../taothongbao/taothongbao';
import { HomePage } from '../home/home';
@Component({
  selector: 'page-admin',
  templateUrl: 'admin.html',
})
export class AdminPage {
data: any;
  constructor(public navCtrl: NavController, public navParams: NavParams) {
    this.data = navParams.get('data');
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad AdminPage');
  }
btlichvadd()
{
	this.navCtrl.push(LichvadanhsachdiemdanhPage,{data:this.data});
}
btdsxinhnghi(){
	this.navCtrl.push(DanhsachxinnghiPage,{data:this.data});
}
bttb(){
this.navCtrl.push(TaothongbaoPage,{MaUS:this.data.MaUser});
}
btlogout()
{
  this.navCtrl.setRoot(HomePage);
}
}
