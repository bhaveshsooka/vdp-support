import { Injectable } from '@nestjs/common';

@Injectable()
export class VdpServicesService {
  findAllHealthCheckServices() {
    return [
      { serviceName: 'service1', healthCheckEndpoint: 'http:service1/health' },
      { serviceName: 'service2', healthCheckEndpoint: 'http:service2/health' },
      { serviceName: 'service3', healthCheckEndpoint: 'http:service3/health' },
      { serviceName: 'service4', healthCheckEndpoint: 'http:service4/health' },
      { serviceName: 'service5', healthCheckEndpoint: 'http:service5/health' },
      { serviceName: 'service6', healthCheckEndpoint: 'http:service6/health' },
      { serviceName: 'service7', healthCheckEndpoint: 'http:service7/health' },
      { serviceName: 'service8', healthCheckEndpoint: 'http:service8/health' },
      { serviceName: 'service9', healthCheckEndpoint: 'http:service9/health' },
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
