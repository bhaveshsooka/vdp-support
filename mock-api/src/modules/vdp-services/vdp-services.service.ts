import { Injectable } from '@nestjs/common';

@Injectable()
export class VdpServicesService {
  findAllHealthCheckServices() {
    return [
      {
        serviceName: 'service1',
        healthCheckEndpoint:
          'http://localhost:3000/vdp-services/health-check-services',
      },
      {
        serviceName: 'service2',
        healthCheckEndpoint:
          'http://localhost:3000/vdp-services/health-check-services',
      },
      {
        serviceName: 'service3',
        healthCheckEndpoint:
          'http://localhost:3000/vdp-services/healdfth-check-services',
      },
      {
        serviceName: 'service4',
        healthCheckEndpoint:
          'http://localhost:300/vdp-services/health-check-services',
      },
      {
        serviceName: 'service5',
        healthCheckEndpoint:
          'http://localhost:3000/vdp-services/health-check-services',
      },
      {
        serviceName: 'service6',
        healthCheckEndpoint:
          'http://localhost:3000/vdp-services/headflth-check-services',
      },
      {
        serviceName: 'service7',
        healthCheckEndpoint:
          'http://localhost:3000/vdp-services/health-check-services',
      },
      {
        serviceName: 'service8',
        healthCheckEndpoint:
          'http://localhost:3000/vdp-services/health-check-services',
      },
      {
        serviceName: 'service9',
        healthCheckEndpoint:
          'http://localhost:3000/vdp-services/hdfealth-check-services',
      },
      {
        serviceName: 'service10',
        healthCheckEndpoint:
          'http://localhost:3000/vdp-services/health-check-services',
      },
    ];
  }

  findAllConsumerServices() {
    return [
      {
        marketName: 'market1',
        consumers: [
          {
            ipAddress: '1.2.3.4',
            pauseEndpoint: 'http://localhost:3000/vdp-services/health-check-services',
            resumeEndpoint: 'http://localhost:3000/vdp-services/health-check-services',
            statusEndpoint: 'http://localhost:3000/vdp-services/health-check-services',
          },
          {
            ipAddress: '5.6.7.8',
            pauseEndpoint: 'http://service2/pause',
            resumeEndpoint: 'http://service2/resume',
            statusEndpoint: 'http://localhost:3000/es',
          },
        ],
      },
      {
        marketName: 'market2',
        consumers: [
          {
            ipAddress: '1.2.3.4',
            pauseEndpoint: 'http://service1/pause',
            resumeEndpoint: 'http://service1/resume',
            statusEndpoint: 'http://service1/status',
          },
        ],
      },
      {
        marketName: 'market3',
        consumers: [
          {
            ipAddress: '1.2.3.4',
            pauseEndpoint: 'http://service3/pause',
            resumeEndpoint: 'http://service3/resume',
            statusEndpoint: 'http://service3/status',
          },
          {
            ipAddress: '1.2.3.4',
            pauseEndpoint: 'http://service3/pause',
            resumeEndpoint: 'http://service3/resume',
            statusEndpoint: 'http://service3/status',
          },
          {
            ipAddress: '1.2.3.4',
            pauseEndpoint: 'http://service3/pause',
            resumeEndpoint: 'http://service3/resume',
            statusEndpoint: 'http://service3/status',
          },
        ],
      },
    ];
  }
}
