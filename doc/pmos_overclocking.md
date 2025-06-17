# pmOS overclocking

- [pmOS overclocking](#pmos-overclocking)
  - [Introduction](#introduction)
  - [The setup process in Maemo Fremantle- Introduction](#the-setup-process-in-maemo-fremantle--introduction)
    - [Creating a boot record for u-boot](#creating-a-boot-record-for-u-boot)
  - [The setup process in pmOS](#the-setup-process-in-pmos)
    - [Creating a `boot.scr` file](#creating-a-bootscr-file)
    - [Creating a modified kernel](#creating-a-modified-kernel)
  - [Checking the success of the operation](#checking-the-success-of-the-operation)
  - [More fine-tuning of core frequency and voltages](#more-fine-tuning-of-core-frequency-and-voltages)
  - [Useful Links](#useful-links)

## Introduction

This manual was created based on a [similar manual for Maemo
Leste](https://leste.maemo.org/Nokia_N900#Overclocking) and adapted by
the pmOS feature.

After this procedure there will be two kernel images in `/boot`
partition: normal and overclocked. If you want, you can always return to
the normal kernel.

The emmc of my N900 has Maemo Fremantle installed with
[u-boot](https://talk.maemo.org/showthread.php?t=81613) installed. This
manual is adapted to this situation.

All manipulations, except those related to setting up u-boot, can be
done directly in pmOS.

This overclock allows you to use a frequency range of 250Mhz to 850Mhz.

## The setup process in Maemo Fremantle- [Introduction](#introduction)

In this step we will create a boot entry for u-boot in Maemo Fremantle.

### Creating a boot record for u-boot

1. Create a new entry for u-boot by creating a file `/etc/bootmenu.d/15-pmos-overclock.item`:

    ```ini
    ITEM_NAME="postmarketOS <Overclock>"
    ITEM_SCRIPT="bootX.scr"
    ITEM_DEVICE="${EXT_CARD}p1"
    ITEM_FSTYPE="ext2"
    ```

2. Run `u-boot-update-bootmenu` to add a new entry.

## The setup process in pmOS

At this point, we modify the existing kernel and add a new system
startup script.

The following commands will create some files. I will create them on the
`/root` path, but you can put them wherever you want. All commands below
will be done as root.

### Creating a `boot.scr` file

1. Create a `boot.cmd` text file the way you want:

    ```bash
    setenv mmcnum 0
    setenv mmcpart 1
    setenv mmctype ext2
    setenv setup_omap_atag 1
    setenv bootargs init=/init.sh rw console=tty0 console=ttyS2 PMOS_NO_OUTPUT_REDIRECT PMOS_FORCE_PARTITION_RESIZE
    setenv mmckernfile /uImageX
    setenv mmcinitrdfile /uInitrd
    setenv mmcscriptfile
    echo Loading initramfs
    run initrdload
    Loading kernel
    run kernload
    echo Booting kernel
    run kerninitrdboot
    ```

2. Create `bootX.scr` file and put it in `/boot`:

    ```console
    # mkimage -c none -A arm -T script -d /root/boot.cmd /boot/bootX.scr
    ```

### Creating a modified kernel

1. Get `omap3-n900.dtb`:

    ```console
    # cp /boot/dtbs/omap3-n900.dtb /root
    ```

2. Get `.dts` file. When you run this command you will see a lot of
    messages, you can ignore them. You may need to install dependencies
    [dtc](https://pkgs.alpinelinux.org/package/edge/main/armhf/dtc):

    ```console
    # dtc -I dtb -O dts /root/omap3-n900.dtb -o /root/omap3-n900.dts
    ```

    ```console
    # chmod +w /root/omap3-n900.dts
    ```

3. Modify `omap3-n900.dts` and add new frequencies. To do this, find
    the `opp-table` section and edit it according to the example below:

    ```ini
            opp-table {
                compatible = "operating-points-v2-ti-cpu";
                syscon = < 0x05 >;
                phandle = < 0x03 >;

                opp1-250000000 {
                    opp-hz = < 0x00 0xee6b280 >;
                    opp-microvolt = < 0xee098 0xee098 0xee098 >;
                    opp-supported-hw = < 0xffffffff 0x03 >;
                };

                opp2-500000000 {
                    opp-hz = < 0x00 0x1dcd6500 >;
                    opp-microvolt = < 0x106738 0x106738 0x106738 >;
                    opp-supported-hw = < 0xffffffff 0x03 >;
                    opp-suspend;
                };

                opp3-600000000 {
                    opp-hz = < 0x00 0x23c34600 >;
                    opp-microvolt = < 0x124f80 0x124f80 0x124f80 >;
                    opp-supported-hw = < 0xffffffff 0x03 >;
                };

                opp4-720000000 {
                    opp-hz = < 0x00 0x2aea5400 >;
                    opp-microvolt = < 0x124f80 0x124f80 0x124f80 >;
                    opp-supported-hw = < 0xffffffff 0x03 >;
                };

                opp5-850000000 {
                    opp-hz = < 0x00 0x32a9f880 >;
                    opp-microvolt = < 0x149970 0x149970 0x149970 >;
                    opp-supported-hw = < 0xffffffffff 0x03 >;
                };

                opp6-720000000 {
                    opp-hz = < 0x00 0x2aea5400 >;
                    opp-microvolt = < 0x149970 0x149970 0x149970 >;
                    opp-supported-hw = < 0xffffffffff 0x02 >;
                    turbo-mode;
                };
            };
    ```

4. Generating a new `.dtb` file:

    ```console
    # rm /root/omap3-n900.dtb
    ```

    ```console
    # dtc -I dts -O dtb /root/omap3-n900.dts -o /root/omap3-n900.dtb
    ```

5. Create a `zImage_dtb`:

    ```console
    # cat /boot/vmlinuz /root/omap3-n900.dtb > /tmp/zImage_dtb
    ```

6. Create and put in `/boot` a new `uImageX`:

    ```console
    # mkimage -A arm -O linux -T kernel -C none -a 80008000 -e 80008000 -d /tmp/zImage_dtb /boot/uImageX
    ```

## Checking the success of the operation

After completing all the steps, reboot pmOS using the new item in the
u-boot that we added.

You can use
[cpufrequtils](https://pkgs.alpinelinux.org/package/edge/community/armhf/cpufrequtils)
to check if new frequencies have been added. The result should be about
the same as below.

```console
nokia-n900:~$ cpufreq-info 
cpufrequtils 008: cpufreq-info (C) Dominik Brodowski 2004-2009
Please report bugs and errors to cpufreq@vger.kernel.org.
analyzing CPU 0:
  driver: cpufreq-dt
  CPUs that run at the same hardware frequency: 0
  CPUs which frequency must be coordinated programmatically: 0
  maximum transition delay: 300 us.
  hardware limitations: 250 MHz - 850 MHz
  available frequency steps: 250 MHz, 500 MHz, 600 MHz, 720 MHz, 850 MHz.
  available cpufreq controls: conservative, on demand, user space, power saving, performance
  current policy: frequency must be within 250 MHz and 850 MHz.
                  The "conservative" controller can decide what speed to use
                  in this range.
  The current CPU frequency is 850 MHz.
```

If everything is correct, the operation is successful!

You can change the mode of the core for more powersafe:

```console
# cpufreq-set -c 0 -g conservative
```

## More fine-tuning of core frequency and voltages

You can try to raise the core frequency above 850 MHz by editing the
`opp-table` to your liking. It all depends on how lucky you are with
your SoC. The voltage and frequency can be edited to get the desired
result.

To increase the core frequency, edit the variable `opp-hz` according to
your wishes. The values must be in HEX format. Example: `0x32a9f880` =
850000000.

To increase the core volts, edit all 3 numbers in the `opp-microvolt`
variable to your liking. The values must be in HEX format. Example:
`0x149970` = 1350000.

On my device I was able to raise the frequency to 890Mhz without raising
the voltage. When I raised the voltage above 1.37V, I lost stability of
the system. The system also lost stability when I raised the frequency
to 900MHz. According to the information I found, no one has raised the
voltage above 1.5V (in Maemo Fremantle).

My final configuration for `oop5` (I repeat, it may not work for you):

```ini
            opp5-890000000 {
                opp-hz = < 0x00 0x350c5280 >;
                opp-microvolt = < 0x149970 0x149970 0x149970 >;
                opp-supported-hw = < 0xffffffffff 0x03 >;
            };
```

| HEX      | MHz     |
|----------|---------|
| 0x7735940  | 125 |
| 0x2aea5400 | 720 |
| 0x2faf0800 | 800 |
| 0x32a9f880 | 850 |
| 0x350c5280 | 890 |
| 0x35a4E900 | 900 |

| HEX      | Voltage (V) |
|----------|-------------|
| 0x149970 | 1.35 |
| 0x14c080 | 1.36 |
| 0x14e790 | 1.37 |

## Useful Links

- [A superficial description of the `opp-table` syntax](https://www.kernel.org/doc/Documentation/devicetree/bindings/opp/opp.txt);

- [Maemo Overclocking wiki page](https://wiki.maemo.org/Overclocking);

- [A helpful note about maximum voltage](https://talk.maemo.org/showpost.php?p=606031&postcount=2375);
