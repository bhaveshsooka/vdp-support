import { Injectable } from '@nestjs/common';

@Injectable()
export class VdpServicesService {
  findAllHealthCheckServices() {
    return [
      { serviceName: 'service1', healthCheckEndpoint: 'http://localhost:3000/vdp-services/health-check-services' },
      { serviceName: 'service2', healthCheckEndpoint: 'http://localhost:3000/vdp-services/health-check-services' },
      { serviceName: 'service3', healthCheckEndpoint: 'http://localhost:3000/vdp-services/healdfth-check-services' },
      { serviceName: 'service4', healthCheckEndpoint: 'http://localhost:300/vdp-services/health-check-services' },
      { serviceName: 'service5', healthCheckEndpoint: 'http://localhost:3000/vdp-services/health-check-services' },
      { serviceName: 'service6', healthCheckEndpoint: 'http://localhost:3000/vdp-services/headflth-check-services' },
      { serviceName: 'service7', healthCheckEndpoint: 'http://localhost:3000/vdp-services/health-check-services' },
      { serviceName: 'service8', healthCheckEndpoint: 'http://localhost:3000/vdp-services/health-check-services' },
      { serviceName: 'service9', healthCheckEndpoint: 'http://localhost:3000/vdp-services/hdfealth-check-services' },
      { serviceName: 'service10', healthCheckEndpoint: 'http://localhost:3000/vdp-services/health-check-services' },
    ];
  }

  findAllConsumerServices() {
    return [
      {
        marketName: 'service1',
        pauseEndpoint: 'http:service1/pause',
        restartEndpoint: 'http:service1/restart',
      },
      {
        marketName: 'service2',
        pauseEndpoint: 'http:service2/pause',
        restartEndpoint: 'http:service2/restart',
      },
      {
        marketName: 'service3',
        pauseEndpoint: 'http:service3/pause',
        restartEndpoint: 'http:service3/restart',
      },
      {
        marketName: 'service4',
        pauseEndpoint: 'http:service4/pause',
        restartEndpoint: 'http:service4/restart',
      },
      {
        marketName: 'service5',
        pauseEndpoint: 'http:service5/pause',
        restartEndpoint: 'http:service5/restart',
      },
      {
        marketName: 'service6',
        pauseEndpoint: 'http:service6/pause',
        restartEndpoint: 'http:service6/restart',
      },
      {
        marketName: 'service7',
        pauseEndpoint: 'http:service7/pause',
        restartEndpoint: 'http:service7/restart',
      },
      {
        marketName: 'service8',
        pauseEndpoint: 'http:service8/pause',
        restartEndpoint: 'http:service8/restart',
      },
      {
        marketName: 'service9',
        pauseEndpoint: 'http:service9/pause',
        restartEndpoint: 'http:service9/restart',
      },
    ];
  }
}
