import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams ,AlertController} from 'ionic-angular';
import { HomePage } from '../home/home';
import { HttpClient} from '@angular/common/http';
import { UserPage } from '../user/user';
@Component({
  selector: 'page-nghiphep',
  templateUrl: 'nghiphep.html',
})
export class NghiphepPage {
  data: any;
  ngayxinphep:string;
  buoi:string;
  lydo:string;

  constructor(private alertCtrl: AlertController, public navCtrl: NavController, private httpClient: HttpClient,public navParams: NavParams) {
    this.data = navParams.get('data');
    if(this.data.MaUser == null)
    {
      this.alertCtrl.create({
        title: "Thông báo",
        subTitle: 'Nhân viên không tồn tại.',
        buttons: [{
          text:"Đóng",
          handler: data =>{
            this.navCtrl.push(HomePage);
          }
        }]
      }).present();
      
    }
    else  {}
    }

  ionViewDidLoad() {
  }
  Send()
  {
    if(this.data.MaUser == null)
    {
      this.alertCtrl.create({
        title: "Thông báo",
        subTitle: 'Nhân viên không tồn tại.',
        buttons: [{
          text:"Đóng",
          handler: data =>{
            this.navCtrl.push(HomePage);
          }
        }]
      }).present();
      
    }
    else  {
      if(this.ngayxinphep !=null&&this.buoi !=null&&this.lydo !=null)
      {
        var link = '/XinPhep/CreateXinPhep?MaUser='+this.data.MaUser+'&NgayPhep='+this.ngayxinphep+'&Buoi='+this.buoi+'&LyDo='+this.lydo;
        this.httpClient.post('/api'+link,'')
            .subscribe(data => {
              let cont = JSON.stringify(data);
              let dat =JSON.parse(cont);
              if(dat.Code ==200){
                this.alertCtrl.create({
                  title: 'Điểm danh',
                  message: 'Xin phép thành công',
                  buttons: [
                    {
                      text: 'Tiếp tục',
                      handler: data => {
                        this.ngayxinphep ='';
                        this.buoi ='';
                        this.lydo ='';
                      }
                    },
                    {
                      text: 'Quay lại',
                      handler: data => {
                        this.navCtrl.push(UserPage,{data:this.data});
                      }
                    }
                  ]
                }).present();
              }
              else if(dat.Code ==201){
                this.alertCtrl.create({
                  title: "Thông báo",
                  subTitle: "Bạn đã xin phép",
                  buttons: ["Đóng"]
                }).present();
              }
              else
              {
                this.alertCtrl.create({
                  title: "Thông báo",
                  subTitle: "Xin phép lỗi, kiểm tra ngày xin phép.",
                  buttons: ["Đóng"]
                }).present();
              }
            });
      }
      else
      {
        this.alertCtrl.create({
          title: "Thông báo",
          subTitle: 'Vui lòng nhập đầy đủ thông tin.',
          buttons: ["Đóng"]
        }).present();
      }
      
    }

  }
}



