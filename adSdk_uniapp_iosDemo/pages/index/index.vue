<template>
	<view class="page">
		<!-- SDK 初始化区 -->
		<view class="card init-card">
			<view class="card-title">xiluAdSdk 初始化</view>
			<view class="form-row">
				<text class="label">AppId</text>
				<input class="input" v-model="appId" placeholder="请输入 xilu 平台 AppId" />
			</view>
			<view class="init-row">
				<text class="status" :class="initStatusClass">{{ initStatusText }}</text>
				<button class="btn small" type="primary" @click="initSdk">{{ inited ? '重新初始化' : '初始化 SDK' }}</button>
			</view>
		</view>

		<!-- 广告类型列表 -->
		<view class="card">
			<view class="card-title">广告类型</view>
			<view class="ad-list">
				<view v-for="(item, index) in adTypes" :key="item.key" class="ad-item"
					:class="{ 'with-border': index < adTypes.length - 1 }" @click="goDetail(item)">
					<view class="ad-item-left">
						<view class="dot" :style="{ backgroundColor: item.color }"></view>
						<view>
							<text class="ad-name">{{ item.name }}</text>
							<text class="ad-desc">{{ item.desc }}</text>
						</view>
					</view>
					<text class="arrow">›</text>
				</view>
			</view>
		</view>

		<view class="tip">提示：广告功能仅支持 iOS（需自定义基座/云打包集成 xiluAdSdk）</view>
	</view>
</template>

<script>
import xiluConfig from '@/common/xilu-config.js';
// #ifdef APP-PLUS
import * as xiluAd from '@/uni_modules/xiluAdSdk';
// #endif

export default {
	data() {
		return {
			appId: xiluConfig.appId,
			inited: false,
			adTypes: [
				{ key: 'splash', name: '开屏广告', desc: 'App 启动时全屏展示', color: '#4f8ff7', url: '/pages/ad/splash/splash' },
				{ key: 'banner', name: 'Banner 广告', desc: '横幅广告，底部悬浮展示', color: '#ff9f43', url: '/pages/ad/banner/banner' },
				{ key: 'interstitial', name: '插屏广告', desc: '场景切换时弹出展示', color: '#ee5253', url: '/pages/ad/interstitial/interstitial' },
				{ key: 'rewardVideo', name: '激励视频广告', desc: '完整观看后获得奖励', color: '#10ac84', url: '/pages/ad/reward/reward' },
				{ key: 'nativeTemplate', name: '信息流模板广告', desc: 'SDK 渲染模板视图', color: '#5f27cd', url: '/pages/ad/native-template/native-template' },
				{ key: 'nativeRender', name: '信息流自渲染广告', desc: '媒体自行渲染素材', color: '#222f3e', url: '/pages/ad/native-render/native-render' }
			]
		};
	},
	computed: {
		initStatusText() {
			// #ifdef APP-PLUS
			return this.inited ? '已初始化' : '未初始化';
			// #endif
			// #ifndef APP-PLUS
			return '当前平台不支持';
			// #endif
		},
		initStatusClass() {
			return this.inited ? 'status-ok' : 'status-wait';
		}
	},
	onShow() {
		// #ifdef APP-PLUS
		if (uni.getSystemInfoSync().platform === 'ios' &&
			typeof xiluAd !== 'undefined' && xiluAd.isInitialized && xiluAd.isInitialized()) {
			this.inited = true;
		}
		// #endif
	},
	methods: {
		initSdk() {
			// #ifdef APP-PLUS
			if (uni.getSystemInfoSync().platform !== 'ios') {
				uni.showModal({
					title: '不支持的平台',
					content: 'xiluAdSdk 广告功能仅支持 iOS，当前设备为 Android',
					showCancel: false
				});
				return;
			}
			if (typeof xiluAd === 'undefined' || !xiluAd.initSDK) {
				uni.showModal({
					title: '基座缺少原生插件',
					content: '当前运行的基座不包含 xiluAdSdk 插件，请制作并使用「自定义调试基座」后重试',
					showCancel: false
				});
				return;
			}
			xiluAd.initSDK({
				appId: this.appId,
				debug: true,
				success: (msg) => {
					this.inited = true;
					uni.showToast({ title: msg || '初始化成功', icon: 'success' });
				},
				fail: (errMsg) => {
					this.inited = false;
					uni.showModal({ title: '初始化失败', content: errMsg, showCancel: false });
				}
			});
			// #endif
			// #ifndef APP-PLUS
			uni.showToast({ title: '请在 iOS App 自定义基座中运行', icon: 'none' });
			// #endif
		},
		goDetail(item) {
			const posId = xiluConfig.posIds[item.key] || '';
			uni.navigateTo({
				url: `${item.url}?posId=${encodeURIComponent(posId)}&title=${encodeURIComponent(item.name)}`
			});
		}
	}
};
</script>

<style>
.page {
	min-height: 100vh;
	background-color: #f2f3f7;
	padding: 24rpx;
	box-sizing: border-box;
}

.card {
	background-color: #ffffff;
	border-radius: 20rpx;
	padding: 28rpx;
	margin-bottom: 24rpx;
}

.card-title {
	font-size: 30rpx;
	font-weight: 600;
	color: #1f2329;
	margin-bottom: 20rpx;
}

.form-row {
	display: flex;
	align-items: center;
}

.label {
	font-size: 26rpx;
	color: #646a73;
	width: 110rpx;
}

.input {
	flex: 1;
	height: 68rpx;
	border: 1rpx solid #e4e6eb;
	border-radius: 12rpx;
	padding: 0 20rpx;
	font-size: 26rpx;
	background-color: #fafbfc;
}

.init-row {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-top: 24rpx;
}

.status {
	font-size: 26rpx;
}

.status-ok {
	color: #10ac84;
}

.status-wait {
	color: #ff9f43;
}

.btn.small {
	margin: 0;
	font-size: 26rpx;
	padding: 0 32rpx;
	line-height: 64rpx;
	height: 64rpx;
}

.ad-list {
	border-radius: 12rpx;
	overflow: hidden;
}

.ad-item {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 26rpx 8rpx;
}

.ad-item.with-border {
	border-bottom: 1rpx solid #f0f1f5;
}

.ad-item-left {
	display: flex;
	align-items: center;
}

.dot {
	width: 16rpx;
	height: 16rpx;
	border-radius: 50%;
	margin-right: 20rpx;
}

.ad-name {
	font-size: 28rpx;
	color: #1f2329;
	display: block;
}

.ad-desc {
	font-size: 22rpx;
	color: #9aa0aa;
	margin-top: 6rpx;
	display: block;
}

.arrow {
	font-size: 40rpx;
	color: #c0c4cc;
}

.tip {
	font-size: 22rpx;
	color: #9aa0aa;
	text-align: center;
	margin-top: 12rpx;
}
</style>
