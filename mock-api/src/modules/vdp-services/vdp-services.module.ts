import { Module } from '@nestjs/common';
import { VdpServicesService } from './vdp-services.service';
import { VdpServicesController } from './vdp-services.controller';

@Module({
  controllers: [VdpServicesController],
  providers: [VdpServicesService]
})
export class VdpServicesModule {}
