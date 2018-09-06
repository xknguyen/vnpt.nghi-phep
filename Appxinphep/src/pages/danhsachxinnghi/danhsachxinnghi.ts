import { Component } from '@angular/core';
import { FabContainer, IonicPage, NavController, NavParams ,AlertController} from 'ionic-angular';
import {ChitietnghiphepPage } from '../chitietnghiphep/chitietnghiphep';
import { HttpClient} from '@angular/common/http';


@Component({
  selector: 'page-danhsachxinnghi',
  templateUrl: 'danhsachxinnghi.html'
})

export class DanhsachxinnghiPage {

selectedItem: any;
icons: string[];
items: Array<{title: string, note: string, icon: string}>;
data: any;
dataXP: any;
constructor(private alertCtrl: AlertController, public navCtrl: NavController, private httpClient: HttpClient,public navParams: NavParams) {
    this.data = navParams.get('data');
    this.icons = ['mail', 'mail-open'];
    this.dataXP='';
    this.Refest();

  }
  ionViewDidLoad(){
    
  }
  getIcon(val:string){
    if (val == 'True') {
      return 'mail-open';
    }
    else  
      return 'mail';  
  }
btchitietnghiphep(val:string)
{
  var link2 = '/XinPhep/DoiTrangThai?MaXP='+val;
  this.httpClient.post('/api'+link2,'')
          .subscribe(data => {
            this.navCtrl.push(ChitietnghiphepPage,{data: this.data, maXP:val});
          });
}
Refest()
{

  
  var link = '/XinPhep/GetXinPhep';
      this.httpClient.get('/api'+link)
          .subscribe(data => {
            let cont = JSON.stringify(data);
            let dat =JSON.parse(cont);
            if(dat.Code ==200){
              this.dataXP = dat.data;
            }
            else
            {
              this.alertCtrl.create({
                title: "Thông báo",
                subTitle: "Lấy danh sách lỗi.",
                buttons: ["Đóng"]
              }).present();
            }
          });
          
  //this.navCtrl.setRoot(this.navCtrl.getActive().component);
}
refresh(fab?: FabContainer): void {
  if (fab !== undefined) {
    fab.close();
  }
  this.Refest();
}
ionViewWillEnter() { // THERE IT IS!!!
  this.Refest();
}
}