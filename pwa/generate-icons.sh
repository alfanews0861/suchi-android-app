#!/bin/bash

# Generate PWA icons from a base image
# This script creates all required icon sizes for a PWA

echo "🎨 Generating PWA icons..."

# Create icons directory
mkdir -p /workspaces/suchi-android-app/pwa/icons

# Icon sizes needed for PWA
SIZES=(16 32 72 96 120 128 144 152 180 192 384 512)

# Create a simple colored icon using ImageMagick (if available)
# If not available, we'll create placeholder instructions

if command -v convert &> /dev/null; then
    echo "✅ ImageMagick found. Generating icons..."
    
    # Generate icons with orange background and white "S" text
    for SIZE in "${SIZES[@]}"; do
        convert -size ${SIZE}x${SIZE} xc:'#FF6B35' \
                -gravity center \
                -pointsize $((SIZE / 2)) \
                -fill white \
                -font Arial-Bold \
                -annotate +0+0 'S' \
                /workspaces/suchi-android-app/pwa/icons/icon-${SIZE}x${SIZE}.png
        echo "   Created icon-${SIZE}x${SIZE}.png"
    done
    
    echo "✅ All icons generated successfully!"
else
    echo "⚠️  ImageMagick not installed. Creating placeholder icons..."
    
    # Create a simple SVG that can be converted manually
    cat > /workspaces/suchi-android-app/pwa/icons/icon-template.svg << 'EOF'
<svg width="512" height="512" xmlns="http://www.w3.org/2000/svg">
  <rect width="512" height="512" fill="#FF6B35"/>
  <text x="256" y="320" font-family="Arial" font-size="280" font-weight="bold" fill="white" text-anchor="middle">S</text>
</svg>
EOF
    
    echo "📝 Created icon-template.svg"
    echo "   Please convert this SVG to PNG files using an online tool:"
    echo "   https://www.iloveimg.com/resize-image"
    echo "   Or use: https://realfavicongenerator.net/"
fi

echo ""
echo "📱 Icon sizes generated:"
for SIZE in "${SIZES[@]}"; do
    echo "   - icon-${SIZE}x${SIZE}.png"
done

echo ""
echo "✅ Icon generation complete!"
