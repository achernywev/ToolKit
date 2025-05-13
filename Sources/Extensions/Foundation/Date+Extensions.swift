import Foundation

public extension Date {
    var daysUntilNow: TimeInterval {
        return durationUntilNow(.days)
    }
    var daysSinceNow: TimeInterval {
        return durationSinceNow(.days)
    }
    func durationUntilNow(_ unit: UnitDuration) -> TimeInterval {
        return -durationSinceNow(unit)
    }
    
    func durationSinceNow(_ unit: UnitDuration) -> TimeInterval {
        let value = timeIntervalSinceNow
        let seconds = Measurement(value: timeIntervalSinceNow, unit: UnitDuration.seconds)
        return seconds.converted(to: unit).value
    }
}

public extension UnitDuration {
    static var days: UnitDuration {
        return UnitDuration(
            symbol: "d",
            converter: UnitConverterLinear(coefficient: 86_400) // 1 day = 86,400 seconds
        )
    }
    static var weeks: UnitDuration {
        return UnitDuration(
            symbol: "w",
            converter: UnitConverterLinear(coefficient: 604_800) // 1 week = 604,800 seconds
        )
    }
}
