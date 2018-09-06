import { BrowserModule } from '@angular/platform-browser';
import { ErrorHandler, NgModule } from '@angular/core';
import { IonicApp, IonicErrorHandler, IonicModule } from 'ionic-angular';
import { SplashScreen } from '@ionic-native/splash-screen';
import { StatusBar } from '@ionic-native/status-bar';
import {HttpClientModule} from '@angular/common/http';
import { LocalNotifications } from '@ionic-native/local-notifications';
import { MyApp } from './app.component';
import { HomePage } from '../pages/home/home';
import { AdminPage } from '../pages/admin/admin';
import { LichvadanhsachdiemdanhPage } from '../pages/lichvadanhsachdiemdanh/lichvadanhsachdiemdanh';
import { LichdangkiPage } from '../pages/lichdangki/lichdangki';
import { DanhsachxinnghiPage } from '../pages/danhsachxinnghi/danhsachxinnghi';
import { ChitietnghiphepPage } from '../pages/chitietnghiphep/chitietnghiphep';
import { TaothongbaoPage } from '../pages/taothongbao/taothongbao';
import { UserPage } from '../pages/user/user';
import { NghiphepPage } from '../pages/nghiphep/nghiphep';
import { DangkilichPage } from '../pages/dangkilich/dangkilich';
import { ThongbaonvPage } from '../pages/thongbaonv/thongbaonv';
import { ChitietthongbaonvPage } from '../pages/chitietthongbaonv/chitietthongbaonv';

@NgModule({
  declarations: [
    MyApp,
    HomePage,
    AdminPage,
    LichvadanhsachdiemdanhPage,
    LichdangkiPage,
    DanhsachxinnghiPage,
    ChitietnghiphepPage,
    TaothongbaoPage,
    UserPage,
    NghiphepPage,
    DangkilichPage,
    ThongbaonvPage,
    ChitietthongbaonvPage
  ],
  imports: [
    BrowserModule,
    IonicModule.forRoot(MyApp),
    HttpClientModule,
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    MyApp,
    HomePage,
    AdminPage,
    LichvadanhsachdiemdanhPage,
    LichdangkiPage,
    DanhsachxinnghiPage,
    ChitietnghiphepPage,
    TaothongbaoPage,
    UserPage,
    NghiphepPage,
    DangkilichPage,
    ThongbaonvPage,
    ChitietthongbaonvPage
  ],
  providers: [
    StatusBar,
    SplashScreen,
    LocalNotifications,
    {provide: ErrorHandler, useClass: IonicErrorHandler},
  ],
})
export class AppModule {}
