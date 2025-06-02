#!/bin/bash

# Test script for local compilation with environment variables
# Replace these with your actual values when testing locally
export EMAIL="your-email@example.com"
export PHONE="+1 (XXX) XXX-XXXX"

echo "Testing local compilation with environment variables..."
just compile

if [ $? -eq 0 ]; then
    echo "✅ Compilation successful!"
    echo "📄 resume.pdf has been generated with your sensitive information"
else
    echo "❌ Compilation failed"
    exit 1
fi
