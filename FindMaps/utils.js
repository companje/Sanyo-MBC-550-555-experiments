function getGradientColor(gradientColors, value) {
    const index = Math.floor((value / 255) * (gradientColors.length - 1));
    const nextIndex = Math.min(index + 1, gradientColors.length - 1);
    const ratio = (value / 255) * (gradientColors.length - 1) - index;
    const startColor = hexToRgb(gradientColors[index]);
    const endColor = hexToRgb(gradientColors[nextIndex]);

    return rgbToHex(
        Math.round(startColor.r + ratio * (endColor.r - startColor.r)),
        Math.round(startColor.g + ratio * (endColor.g - startColor.g)),
        Math.round(startColor.b + ratio * (endColor.b - startColor.b))
    );
}

function hexToRgb(hex) {
    const bigint = parseInt(hex.slice(1), 16);
    return {
        r: (bigint >> 16) & 255,
        g: (bigint >> 8) & 255,
        b: bigint & 255
    };
}

function rgbToHex(r, g, b) {
    return `#${((1 << 24) | (r << 16) | (g << 8) | b).toString(16).slice(1)}`;
}