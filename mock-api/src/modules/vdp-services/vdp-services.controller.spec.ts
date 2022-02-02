import { Test, TestingModule } from '@nestjs/testing';
import { VdpServicesController } from './vdp-services.controller';
import { VdpServicesService } from './vdp-services.service';

describe('VdpServicesController', () => {
  let controller: VdpServicesController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [VdpServicesController],
      providers: [VdpServicesService],
    }).compile();

    controller = module.get<VdpServicesController>(VdpServicesController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
