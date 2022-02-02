import { Controller, Get } from '@nestjs/common';
import { VdpServicesService } from './vdp-services.service';

@Controller('vdp-services')
export class VdpServicesController {
  constructor(private readonly vdpServicesService: VdpServicesService) {}

  @Get('/consumers')
  findAllConsumerServices() {
    return this.vdpServicesService.findAllConsumerServices();
  }

  @Get('/health-check-services')
  findAllHealthCheckServices() {
    return this.vdpServicesService.findAllHealthCheckServices();
  }
}
