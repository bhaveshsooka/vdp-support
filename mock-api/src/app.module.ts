import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { VdpServicesModule } from './modules/vdp-services/vdp-services.module';

@Module({
  imports: [VdpServicesModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
