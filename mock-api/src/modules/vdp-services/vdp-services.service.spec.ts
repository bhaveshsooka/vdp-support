import { Test, TestingModule } from '@nestjs/testing';
import { VdpServicesService } from './vdp-services.service';

describe('VdpServicesService', () => {
  let service: VdpServicesService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [VdpServicesService],
    }).compile();

    service = module.get<VdpServicesService>(VdpServicesService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
