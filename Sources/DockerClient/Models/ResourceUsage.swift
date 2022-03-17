import Foundation

public struct ResourceUsage: Decodable {
    public let id: String
    public let name: String
    public let read: Date
    public let blkIOStats: BlkIOStats
    public let cpuStats: CPUStats
    public let memoryStats: MemoryStats
    public let networkStats: [String: NetworkStats]?
    public let pidsStats: PidsStats
    public let preCpuStats: CPUStats
    public let storageStats: StorageStats

    enum CodingKeys: String, CodingKey {
        case id, name, read
        case blkIOStats = "blkio_stats"
        case cpuStats = "cpu_stats"
        case memoryStats = "memory_stats"
        case networkStats = "networks"
        case pidsStats = "pids_stats"
        case preCpuStats = "precpu_stats"
        case storageStats = "storage_stats"
    }

    public struct BlkIOStats: Decodable {
        public let ioServiceBytesRecursive: [BlkIOStatsItem]?
        public let ioServicedRecursive: [BlkIOStatsItem]?
        public let ioQueueRecursive: [BlkIOStatsItem]?
        public let ioServiceTimeRecursive: [BlkIOStatsItem]?
        public let ioWaitTimeRecursive: [BlkIOStatsItem]?
        public let ioMergedRecursive: [BlkIOStatsItem]?
        public let ioTimeRecursive: [BlkIOStatsItem]?
        public let sectorsRecursive: [BlkIOStatsItem]?

        enum CodingKeys: String, CodingKey {
            case ioServiceBytesRecursive = "io_service_bytes_recursive"
            case ioServicedRecursive = "io_serviced_recursive"
            case ioQueueRecursive = "io_queue_recursive"
            case ioServiceTimeRecursive = "io_service_time_recursive"
            case ioWaitTimeRecursive = "io_wait_time_recursive"
            case ioMergedRecursive = "io_merged_recursive"
            case ioTimeRecursive = "io_time_recursive"
            case sectorsRecursive = "sectors_recursive"
        }

        public struct BlkIOStatsItem: Decodable {
            public let major: Int
            public let minor: Int
            public let op: String
            public let value: Int
        }
    }

    public struct CPUStats: Decodable {
        public let cpuUsage: CPUUsage
        public let systemCPUUsage: Int?
        public let onlineCPUs: Int?
        public let throttlingData: ThrottlingData

        enum CodingKeys: String, CodingKey {
            case cpuUsage = "cpu_usage"
            case systemCPUUsage = "system_cpu_usage"
            case onlineCPUs = "online_cpus"
            case throttlingData = "throttling_data"
        }
    }

    public struct CPUUsage: Decodable {
        public let totalUsage: Int
        public let usageInKernelmode: Int
        public let usageInUsermode: Int

        enum CodingKeys: String, CodingKey {
            case totalUsage = "total_usage"
            case usageInKernelmode = "usage_in_kernelmode"
            case usageInUsermode = "usage_in_usermode"
        }
    }

    public struct MemoryStats: Decodable {
        public let usage: Int?
        public let limit: Int?
        public let stats: Stats?

        public struct Stats: Decodable {
            public let activeAnon: Int?
            public let activeFile: Int?
            public let anon: Int?
            public let anonThp: Int?
            public let file: Int?
            public let fileDirty: Int?
            public let fileMapped: Int?
            public let fileWriteback: Int?
            public let inactiveAnon: Int?
            public let inactiveFile: Int?
            public let kernelStack: Int?
            public let pgactivate: Int?
            public let pgdeactivate: Int?
            public let pgfault: Int?
            public let pglazyfree: Int?
            public let pglazyfreed: Int?
            public let pgmajfault: Int?
            public let pgrefill: Int?
            public let pgscan: Int?
            public let pgsteal: Int?
            public let shmem: Int?
            public let slab: Int?
            public let slabReclaimable: Int?
            public let slabUnreclaimable: Int?
            public let sock: Int?
            public let thpCollapseAlloc: Int?
            public let thpFaultAlloc: Int?
            public let unevictable: Int?
            public let workingsetActivate: Int?
            public let workingsetNodereclaim: Int?
            public let workingsetRefault: Int?

            enum CodingKeys: String, CodingKey {
                case activeAnon = "active_anon"
                case activeFile = "active_file"
                case anon = "anon"
                case anonThp = "anon_thp"
                case file = "file"
                case fileDirty = "file_dirty"
                case fileMapped = "file_mapped"
                case fileWriteback = "file_writeback"
                case inactiveAnon = "inactive_anon"
                case inactiveFile = "inactive_file"
                case kernelStack = "kernel_stack"
                case pgactivate = "pgactivate"
                case pgdeactivate = "pgdeactivate"
                case pgfault = "pgfault"
                case pglazyfree = "pglazyfree"
                case pglazyfreed = "pglazyfreed"
                case pgmajfault = "pgmajfault"
                case pgrefill = "pgrefill"
                case pgscan = "pgscan"
                case pgsteal = "pgsteal"
                case shmem = "shmem"
                case slab = "slab"
                case slabReclaimable = "slab_reclaimable"
                case slabUnreclaimable = "slab_unreclaimable"
                case sock = "sock"
                case thpCollapseAlloc = "thp_collapse_alloc"
                case thpFaultAlloc = "thp_fault_alloc"
                case unevictable = "unevictable"
                case workingsetActivate = "workingset_activate"
                case workingsetNodereclaim = "workingset_nodereclaim"
                case workingsetRefault = "workingset_refault"
            }
        }
    }

    public struct NetworkStats: Decodable {
        public let rxBytes: Int?
        public let rxPackets: Int?
        public let rxErrors: Int?
        public let rxDropped: Int?
        public let txBytes: Int?
        public let txPackets: Int?
        public let txErrors: Int?
        public let txDropped: Int?

        enum CodingKeys: String, CodingKey {
            case rxBytes = "rx_bytes"
            case rxPackets = "rx_packets"
            case rxErrors = "rx_errors"
            case rxDropped = "rx_dropped"
            case txBytes = "tx_bytes"
            case txPackets = "tx_packets"
            case txErrors = "tx_errors"
            case txDropped = "tx_dropped"
        }
    }

    public struct PidsStats: Decodable {
        public let current: Int?
    }

    public struct StorageStats: Decodable {
    }

    public struct ThrottlingData: Decodable {
        public let periods: Int
        public let throttledPeriods: Int
        public let throttledTime: Int

        enum CodingKeys: String, CodingKey {
            case periods
            case throttledPeriods = "throttled_periods"
            case throttledTime = "throttled_time"
        }
    }
}
