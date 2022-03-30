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
        environments: [
          {
            environmentName: 'dev',
            consumers: [
              {
                ipAddress: '1.2.3.4',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://localhost:3000/vdp-services/health-check-services',
              },
              {
                ipAddress: '1.2.3.4',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://localhost:3000/failed',
              },
              {
                ipAddress: '1.2.3.4',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://service3/status',
              },
            ],
          },
          {
            environmentName: 'test',
            consumers: [
              {
                ipAddress: '2.3.4.1',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://service3/status',
              },
              {
                ipAddress: '2.3.4.1',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://service3/status',
              },
              {
                ipAddress: '2.3.4.1',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://service3/status',
              },
            ],
          },
          {
            environmentName: 'uat',
            consumers: [
              {
                ipAddress: '3.4.1.2',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://service3/status',
              },
              {
                ipAddress: '3.4.1.2',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://service3/status',
              },
              {
                ipAddress: '3.4.1.2',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://service3/status',
              },
            ],
          },
          {
            environmentName: 'prod',
            consumers: [
              {
                ipAddress: '4.1.2.3',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://service3/status',
              },
              {
                ipAddress: '4.1.2.3',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://service3/status',
              },
              {
                ipAddress: '4.1.2.3',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://service3/status',
              },
            ],
          },
        ],
      },
      {
        marketName: 'market2',
        environments: [
          {
            environmentName: 'dev',
            consumers: [
              {
                ipAddress: '1.2.3.4',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://service3/status',
              },
            ],
          },
          {
            environmentName: 'test',
            consumers: [
              {
                ipAddress: '2.3.4.1',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://service3/status',
              },
            ],
          },
          {
            environmentName: 'uat',
            consumers: [
              {
                ipAddress: '3.4.1.2',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://service3/status',
              },
            ],
          },
          {
            environmentName: 'prod',
            consumers: [
              {
                ipAddress: '4.1.2.3',
                pauseEndpoint: 'http://service3/pause',
                resumeEndpoint: 'http://service3/resume',
                statusEndpoint: 'http://service3/status',
              },
            ],
          },
        ],
      },
    ];
  }
}
