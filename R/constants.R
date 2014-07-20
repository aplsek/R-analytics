
GC_TYPES <- c("g1-young", "g1evac", "g1full", "g1-young_to-spaceexhausted", "g1-young_initial-mark_to-spaceexhausted", "g1-young_initial-mark", "g1-mixed", "ParOld-minor", "ParOld-full", "ParOld-full-meta")
colors <- c("blue", "green", "red", "dark red", "dark red", "yellow", "brown")
#GC_TYPES <-  data.frame(colors,types)

ROUND = 3

headers = c("PauseTime [s]", "AvgPause [s]", "MaxPause [s]", "#Gc-Pause",
            "RunTime [s]", "GC-Throughput [%]", "GC Full", "GC Full Pause [s]" )
stats = c()


