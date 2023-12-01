package at.fhv.journey.model;

public enum MonthBitmaskFlags {
    Jan(1), // 0000 0000 0001
    Feb(2), // 0000 0000 0010
    Mar(4), // 0000 0000 0100
    Apr(8), // 0000 0000 1000
    May(16), // 0000 0001 0000
    Jun(32), // 0000 0010 0000
    Jul(64), // 0000 0100 0000
    Aug(128), // 0000 1000 0000
    Sep(256), // 0001 0000 0000
    Oct(512), // 0010 0000 0000
    Nov(1024), // 0100 0000 0000
    Dec(2048);  // 1000 0000 0000

    private final int value;

    MonthBitmaskFlags(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
